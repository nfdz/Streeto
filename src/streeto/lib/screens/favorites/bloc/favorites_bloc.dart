import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:streeto/common/pair.dart';
import 'package:streeto/model/location_details.dart';
import 'package:streeto/persistences/favorites/favorites_persistence.dart';
import 'package:streeto/persistences/persistences_locator.dart';
import 'package:streeto/screens/favorites/bloc/favorites_event.dart';
import 'package:streeto/screens/favorites/bloc/favorites_state.dart';
import 'package:streeto/services/locations/locations_service.dart';
import 'package:streeto/services/maps/maps_service.dart';
import 'package:streeto/services/services_locator.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final Logger _logger = Logger("FavoritesBloc");
  final MapsService _mapsService = ServicesLocator.getService<MapsService>();
  final LocationsService _locationsService = ServicesLocator.getService<LocationsService>();
  final FavoritesPersistence _favsPersistence = PersistencesLocator.getPersistence<FavoritesPersistence>();
  List<LocationDetails> _favorites;
  LocationDetails _selectedLocation;
  int _mapHeight;
  int _mapWidth;

  @override
  FavoritesState get initialState => FavoritesState.initial();

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    _logger.fine("Event: $event");
    if (event is LoadFavorites) {
      _mapWidth = event.mapWidth.round();
      _mapHeight = event.mapHeight.round();
      yield await _getContent();
    } else if (event is SelectLocation) {
      _selectedLocation = event.location;
      yield await _getContent();
    } else if (event is OpenNavigation) {
      if (_selectedLocation != null) {
        _locationsService.openNavigation(_selectedLocation);
      }
    }
  }

  Future<FavoritesState> _getContent() async {
    if (_favorites == null) {
      _favorites = await _favsPersistence.getFavorites();
    }
    String mapImageUrl;
    if (_selectedLocation != null) {
      mapImageUrl = _mapsService.getMapImageUrlForLocation(
        _selectedLocation.lat,
        _selectedLocation.lon,
        _mapWidth,
        _mapHeight,
      );
    } else if (_favorites?.isNotEmpty == true) {
      mapImageUrl = _mapsService.getMapImageUrlForLocationGroup(
        _favorites.map((location) => Pair<double, double>(location.lat, location.lon)).toList(),
        _mapWidth,
        _mapHeight,
      );
    }
    return FavoritesState.content(_favorites, _selectedLocation, mapImageUrl);
  }
}
