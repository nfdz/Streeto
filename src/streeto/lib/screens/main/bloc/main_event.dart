import 'package:meta/meta.dart';
import 'package:streeto/persistences/preferences/preferences.dart';

@immutable
abstract class MainEvent {
  static MainEvent checkLocation() => CheckLocation();
  static MainEvent requestPermissions() => RequestPermissions();
  static MainEvent checkSystemSettings() => CheckSystemSettings();
  static MainEvent searchLocations(String query) => SearchLocations(query);
  static MainEvent sortSuggestions(SuggestionsSort sort) => SortSuggestions(sort);
}

class CheckLocation extends MainEvent {}

class RequestPermissions extends MainEvent {}

class CheckSystemSettings extends MainEvent {}

class SortSuggestions extends MainEvent {
  final SuggestionsSort sort;
  SortSuggestions(this.sort);
  @override
  String toString() => "SortSuggestions(sort: '$sort')";
}

class SearchLocations extends MainEvent {
  final String query;
  SearchLocations(this.query);
  @override
  String toString() => "SearchLocations(query: '$query')";
}
