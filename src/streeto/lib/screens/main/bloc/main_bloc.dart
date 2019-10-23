import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:streeto/model/location_suggestion.dart';
import 'package:streeto/persistences/persistences_locator.dart';
import 'package:streeto/persistences/preferences/preferences.dart';
import 'package:streeto/screens/main/bloc/main_event.dart';
import 'package:streeto/screens/main/bloc/main_state.dart';
import 'package:streeto/services/locations/locations_service.dart';
import 'package:streeto/services/services_locator.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final Logger _logger = Logger("MainBloc");
  final LocationsService _locationsService = ServicesLocator.getService<LocationsService>();
  final Preferences preferences = PersistencesLocator.getPersistence<Preferences>();

  @override
  MainState get initialState => MainState.initial();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    _logger.fine("Event: $event");
    if (event is CheckLocation) {
      yield await handleCheckLocationEvent();
    } else if (event is RequestPermissions) {
      bool granted = await _locationsService.requestLocationPermissions();
      if (granted) {
        yield await handleCheckLocationEvent();
      }
    } else if (event is CheckSystemSettings) {
      await _locationsService.checkSystemSettings();
    } else if (event is SearchLocations) {
      try {
        yield MainState.loading();
        if (event.query?.isNotEmpty == true) {
          final result = await _locationsService.queryLocations(event.query);
          yield result != null
              ? MainState.searchResult(_sortResult(result, await preferences.getSuggestionsSort()))
              : MainState.searchError();
        } else {
          yield MainState.initial();
        }
      } on PermissionsNeededException {
        yield MainState.permissionsNeeded();
      } on LocationNeededException {
        yield MainState.locationError();
      }
    } else if (event is SortSuggestions) {
      final previousState = currentState;
      if (previousState is SearchResult) {
        yield MainState.searchResult(_sortResult(previousState.locations, event.sort));
      }
      await preferences.setSuggestionsSort(event.sort);
    } else if (event is SetNavigation) {
      await preferences.setNavigationProvider(event.nav);
    }
  }

  Future<MainState> handleCheckLocationEvent() async {
    try {
      final hasLocation = await _locationsService.checkCurrentLocation();
      return hasLocation ? MainState.initial() : MainState.locationError();
    } on PermissionsNeededException {
      return MainState.permissionsNeeded();
    }
  }

  List<LocationSuggestion> _sortResult(List<LocationSuggestion> locations, SuggestionsSort sort) {
    switch (sort) {
      case SuggestionsSort.BY_NAME:
        locations.sort((locA, locB) => locA.label.compareTo(locB.label));
        break;
      case SuggestionsSort.BY_DISTANCE:
        locations.sort((locA, locB) => locA.distanceInMeters.compareTo(locB.distanceInMeters));
        break;
    }
    return locations;
  }
}
