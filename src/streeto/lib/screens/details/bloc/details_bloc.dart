import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:streeto/model/location_details.dart';
import 'package:streeto/persistences/favorites/favorites_persistence.dart';
import 'package:streeto/persistences/persistences_locator.dart';
import 'package:streeto/screens/details/bloc/details_event.dart';
import 'package:streeto/screens/details/bloc/details_state.dart';
import 'package:streeto/services/locations/locations_service.dart';
import 'package:streeto/services/maps/maps_service.dart';
import 'package:streeto/services/services_locator.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final Logger _logger = Logger("DetailsBloc");
  final LocationsService _locationsService = ServicesLocator.getService<LocationsService>();
  final MapsService _mapsService = ServicesLocator.getService<MapsService>();
  final FavoritesPersistence _favsPersistence = PersistencesLocator.getPersistence<FavoritesPersistence>();
  String _locationId;
  String _label;
  double _distanceInMeters;
  int _mapHeight;
  int _mapWidth;
  LocationDetails _details;
  String _mapUrl;

  @override
  DetailsState get initialState => DetailsState.loading();

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    _logger.fine("Event: $event");
    if (event is LoadDetails) {
      _locationId = event.location.locationId;
      _label = event.location.label;
      _distanceInMeters = event.location.distanceInMeters;
      _mapHeight = event.mapHeight.round();
      _mapWidth = event.mapWidth.round();
      yield await _getDetails();
    } else if (event is RetryLoadDetails) {
      yield DetailsState.loading();
      yield await _getDetails();
    } else if (event is OpenNavigation) {
      _locationsService.openNavigation(_details);
    } else if (event is AddFavorite) {
      await _favsPersistence.addFavorite(_details);
      yield DetailsState.detailsContent(_details, _distanceInMeters, _mapUrl, true);
    } else if (event is RemoveFavorite) {
      await _favsPersistence.removeFavorite(_locationId);
      yield DetailsState.detailsContent(_details, _distanceInMeters, _mapUrl, false);
    }
  }

  Future<DetailsState> _getDetails() async {
    _details = await _locationsService.getDetails(_locationId, _label);
    if (_details != null) {
      _mapUrl = _mapsService.getMapImageUrlForLocation(_details.lat, _details.lon, _mapWidth, _mapHeight);
      bool isFavorite = await _favsPersistence.isFavorite(_locationId);
      return DetailsState.detailsContent(_details, _distanceInMeters, _mapUrl, isFavorite);
    } else {
      return DetailsState.loadDetailsError();
    }
  }
}
