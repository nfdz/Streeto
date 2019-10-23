import 'package:streeto/model/location_details.dart';
import 'package:streeto/model/location_suggestion.dart';
import 'package:streeto/persistences/preferences/preferences.dart';
import 'package:streeto/services/service.dart';

abstract class LocationsService extends Service {
  Future<List<LocationSuggestion>> queryLocations(String query);
  Future<bool> checkCurrentLocation();
  Future<bool> requestLocationPermissions();
  Future<bool> checkSystemSettings();
  Future<LocationDetails> getDetails(String locationId, String label);
  Future<bool> openNavigation(LocationDetails location, NavigationProvider nav);
}

class PermissionsNeededException implements Exception {
  String errMsg() => 'Permissions needed';
}

class LocationNeededException implements Exception {
  String errMsg() => 'Current location needed';
}
