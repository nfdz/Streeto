import 'package:streeto/common/constants.dart';
import 'package:streeto/model/location_details.dart';
import 'package:streeto/persistences/favorites/favorites_persistence.dart';

class FavoritesPersistenceMock extends FavoritesPersistence {
  final Map<String, LocationDetails> favorites = {};

  @override
  Future<void> clearPersistence() async {
    doFakeDelayIfNeeded();
    favorites.clear();
  }

  @override
  Future<void> addFavorite(LocationDetails location) async {
    doFakeDelayIfNeeded();
    favorites[location.locationId] = location;
  }

  @override
  Future<List<LocationDetails>> getFavorites() async {
    doFakeDelayIfNeeded();
    return favorites.values.toList();
  }

  @override
  Future<bool> isFavorite(String locationId) async {
    doFakeDelayIfNeeded();
    return favorites.containsKey(locationId);
  }

  @override
  Future<void> removeFavorite(String locationId) async {
    doFakeDelayIfNeeded();
    return favorites.remove(locationId);
  }
}
