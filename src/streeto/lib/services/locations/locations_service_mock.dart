import 'package:streeto/common/constants.dart';
import 'package:streeto/model/location_details.dart';
import 'package:streeto/model/location_suggestion.dart';
import 'package:streeto/persistences/preferences/preferences.dart';
import 'package:streeto/services/locations/locations_service.dart';

class LocationsServiceMock extends LocationsService {
  static final List<LocationSuggestion> mockContent = List.generate(
    100,
    (i) {
      return LocationSuggestion(locationId: "$i", label: "Label $i", distanceInMeters: 100.0 * i);
    },
  );

  @override
  Future<List<LocationSuggestion>> queryLocations(String query) async {
    await doFakeDelayIfNeeded();
    return mockContent.where((loc) => loc.label.contains(query)).toList();
  }

  @override
  Future<bool> checkCurrentLocation() async {
    await doFakeDelayIfNeeded();
    return true;
  }

  @override
  Future<bool> checkSystemSettings() async {
    await doFakeDelayIfNeeded();
    return true;
  }

  @override
  Future<bool> requestLocationPermissions() async {
    await doFakeDelayIfNeeded();
    return true;
  }

  @override
  Future<LocationDetails> getDetails(String locationId, String label) async {
    await doFakeDelayIfNeeded();
    return LocationDetails(
      locationId: locationId,
      lat: kMockLocationLat,
      lon: kMockLocationLon,
      postalCode: locationId,
      street: "St $locationId",
      label: label,
    );
  }

  @override
  Future<bool> openNavigation(LocationDetails location, NavigationProvider nav) async {
    await doFakeDelayIfNeeded();
    return true;
  }
}
