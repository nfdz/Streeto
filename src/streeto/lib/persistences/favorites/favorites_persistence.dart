import 'package:streeto/model/location_details.dart';
import 'package:streeto/persistences/persistence.dart';

abstract class FavoritesPersistence extends Persistence {
  Future<List<LocationDetails>> getFavorites();
  Future<void> addFavorite(LocationDetails location);
  Future<void> removeFavorite(String locationId);
  Future<bool> isFavorite(String locationId);
}
