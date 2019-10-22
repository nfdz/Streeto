import 'package:meta/meta.dart';
import 'package:streeto/model/location_details.dart';

@immutable
abstract class FavoritesState {
  static FavoritesState initial() => Initial();
  static FavoritesState content(List<LocationDetails> locations, LocationDetails selected, String mapImageUrl) =>
      FavoritesContent(locations, selected, mapImageUrl);
}

class Initial extends FavoritesState {}

class FavoritesContent extends FavoritesState {
  final List<LocationDetails> locations;
  final LocationDetails selected;
  final String mapImageUrl;
  FavoritesContent(this.locations, this.selected, this.mapImageUrl);
}
