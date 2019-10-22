import 'package:meta/meta.dart';
import 'package:streeto/model/location_details.dart';

@immutable
abstract class FavoritesEvent {
  static FavoritesEvent loadFavorites(double mapWidth, double mapHeight) => LoadFavorites(mapWidth, mapHeight);
  static FavoritesEvent openNavigation() => OpenNavigation();
  static FavoritesEvent selectLocation(LocationDetails location) => SelectLocation(location);
}

class OpenNavigation extends FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {
  final double mapWidth;
  final double mapHeight;
  LoadFavorites(this.mapWidth, this.mapHeight);
}

class SelectLocation extends FavoritesEvent {
  final LocationDetails location;
  SelectLocation(this.location);
}
