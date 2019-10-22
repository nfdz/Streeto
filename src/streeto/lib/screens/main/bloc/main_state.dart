import 'package:meta/meta.dart';
import 'package:streeto/model/location_suggestion.dart';

@immutable
abstract class MainState {
  static MainState initial() => Initial();
  static MainState loading() => Loading();
  static MainState permissionsNeeded() => PermissionsNeeded();
  static MainState locationError() => LocationError();
  static MainState searchError() => SearchError();
  static MainState searchResult(List<LocationSuggestion> locations) => SearchResult(locations);

  void accept(MainStateVisitor visitor);
}

class Initial extends MainState {
  @override
  void accept(MainStateVisitor visitor) => visitor.visitInitial();
}

class PermissionsNeeded extends MainState {
  @override
  void accept(MainStateVisitor visitor) => visitor.visitPermissionsNeeded();
}

class Loading extends MainState {
  @override
  void accept(MainStateVisitor visitor) => visitor.visitLoading();
}

class LocationError extends MainState {
  @override
  void accept(MainStateVisitor visitor) => visitor.visitLocationError();
}

class SearchError extends MainState {
  @override
  void accept(MainStateVisitor visitor) => visitor.visitSearchError();
}

class SearchResult extends MainState {
  final List<LocationSuggestion> locations;
  SearchResult(this.locations);

  @override
  void accept(MainStateVisitor visitor) => visitor.visitSearchResult(locations);
}

// (visitor pattern)
abstract class MainStateVisitor {
  void visitInitial();
  void visitPermissionsNeeded();
  void visitLoading();
  void visitLocationError();
  void visitSearchError();
  void visitSearchResult(List<LocationSuggestion> locations);
}
