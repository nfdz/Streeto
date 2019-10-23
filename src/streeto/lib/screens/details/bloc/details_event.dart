import 'package:meta/meta.dart';
import 'package:streeto/model/location_suggestion.dart';
import 'package:streeto/persistences/preferences/preferences.dart';

@immutable
abstract class DetailsEvent {
  static DetailsEvent loadDetails(LocationSuggestion location, double mapWidth, double mapHeight) =>
      LoadDetails(location, mapWidth, mapHeight);
  static DetailsEvent openNavigation() => OpenNavigation();
  static DetailsEvent retryLoadDetails() => RetryLoadDetails();
  static DetailsEvent addFavorite() => AddFavorite();
  static DetailsEvent removeFavorite() => RemoveFavorite();
  static DetailsEvent setNavigation(NavigationProvider nav) => SetNavigation(nav);
}

class SetNavigation extends DetailsEvent {
  final NavigationProvider nav;
  SetNavigation(this.nav);
  @override
  String toString() => "SetNavigation(nav: '$nav')";
}

class OpenNavigation extends DetailsEvent {}

class RetryLoadDetails extends DetailsEvent {}

class AddFavorite extends DetailsEvent {}

class RemoveFavorite extends DetailsEvent {}

class LoadDetails extends DetailsEvent {
  final LocationSuggestion location;
  final double mapWidth;
  final double mapHeight;
  LoadDetails(this.location, this.mapWidth, this.mapHeight);
  @override
  String toString() => "LoadDetails(location: $location, mapWidth: $mapWidth, mapHeight: $mapHeight)";
}
