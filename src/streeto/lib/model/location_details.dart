import 'package:meta/meta.dart';

class LocationDetails {
  final String street;
  final String postalCode;
  final double lat;
  final double lon;
  final String label;
  final String locationId;
  LocationDetails({
    @required this.street,
    @required this.postalCode,
    @required this.lat,
    @required this.lon,
    @required this.label,
    @required this.locationId,
  });
}
