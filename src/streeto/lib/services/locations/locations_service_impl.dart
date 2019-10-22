import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:streeto/apis/chopper_api_provider.dart';
import 'package:streeto/apis/geocoder_autocomplete_api.dart';
import 'package:streeto/apis/here_wego_helper.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/model/location_details.dart';
import 'package:streeto/model/location_suggestion.dart';
import 'package:streeto/services/locations/locations_service.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class LocationsServiceImpl extends LocationsService {
  final bool mockLocation;
  final Logger _logger = Logger("LocationsServiceImpl");
  final autocompleteApi = ChopperApiProvider.provideGeocoderAutocomplete();
  final geocoderApi = ChopperApiProvider.provideGeocoder();
  Position _userPosition;

  LocationsServiceImpl({this.mockLocation = false});

  @override
  Future<List<LocationSuggestion>> queryLocations(String query) async {
    bool hasPermissions = await checkPermissions();
    if (!hasPermissions) {
      throw PermissionsNeededException();
    } else if (query?.isNotEmpty == true) {
      await getLocationIfNeeded();
      if (_userPosition == null) {
        throw LocationNeededException();
      } else {
        return await _handleQueryLocations(query);
      }
    } else {
      return [];
    }
  }

  Future<List<LocationSuggestion>> _handleQueryLocations(String query) async {
    try {
      final latLon = GeocoderAutocompleteApi.formatLatLong(_userPosition.latitude, _userPosition.longitude);
      final response = await autocompleteApi.getSuggestions(query: query, latLon: latLon);
      if (response.isSuccessful) {
        return response.body.suggestions
            .map((entry) => LocationSuggestion(
                  locationId: entry.locationId ?? "",
                  label: entry.label ?? "",
                  distanceInMeters: entry.distance ?? 0,
                ))
            .toList();
      } else {
        _logger.warning(response.error);
        return null;
      }
    } catch (e) {
      _logger.warning(e);
      return null;
    }
  }

  @override
  Future<bool> checkCurrentLocation() async {
    bool hasLocation = await getLocationIfNeeded();
    return hasLocation;
  }

  @override
  Future<bool> requestLocationPermissions() async {
    bool hasPermissions = await checkPermissions();
    if (hasPermissions) {
      return true;
    }
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.location]);
    return permissions[PermissionGroup.location] == PermissionStatus.granted;
  }

  @override
  Future<bool> checkSystemSettings() async {
    return PermissionHandler().openAppSettings();
  }

  Future<bool> checkPermissions() async {
    if (mockLocation) {
      return true;
    } else {
      PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
      return status == PermissionStatus.granted;
    }
  }

  Future<bool> getLocationIfNeeded() async {
    if (mockLocation) {
      _userPosition = Position(latitude: kMockLocationLat, longitude: kMockLocationLon);
    }
    if (_userPosition == null) {
      _userPosition = await tryGetCurrentLocation();
    }
    return _userPosition != null;
  }

  Future<Position> tryGetCurrentLocation() async {
    ServiceStatus serviceStatus = await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    if (serviceStatus != ServiceStatus.enabled) {
      return null;
    }
    bool hasPermissions = await checkPermissions();
    if (!hasPermissions) {
      throw PermissionsNeededException();
    }
    try {
      return await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .timeout(Duration(seconds: 4));
    } catch (e) {
      _logger.warning(e);
      return null;
    }
  }

  @override
  Future<LocationDetails> getDetails(String locationId, String label) async {
    try {
      final response = await geocoderApi.getDetails(locationId: locationId);
      if (response.isSuccessful) {
        final locationResponse = response.body.response.view.first.result.first.location;
        return LocationDetails(
          lat: locationResponse.displayPosition.latitude ?? 0,
          lon: locationResponse.displayPosition.longitude ?? 0,
          street: locationResponse.address.street ?? "",
          postalCode: locationResponse.address.postalCode ?? "",
          locationId: locationId,
          label: label,
        );
      } else {
        _logger.warning(response.error);
        return null;
      }
    } catch (e) {
      _logger.warning(e);
      return null;
    }
  }

  @override
  Future<bool> openNavigation(LocationDetails location) async {
    if (location != null) {
      String navUrl = _userPosition != null
          ? HereWeGoHelper.buildNavigationUrl(
              _userPosition.latitude,
              _userPosition.longitude,
              location.lat,
              location.lon,
            )
          : HereWeGoHelper.buildMapUrl(location.lat, location.lon);
      if (await UrlLauncher.canLaunch(navUrl)) {
        await UrlLauncher.launch(navUrl);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
