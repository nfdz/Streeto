import 'package:meta/meta.dart';

class LocationSuggestion {
  final String locationId;
  final String label;
  final double distanceInMeters;
  LocationSuggestion({
    @required this.locationId,
    @required this.label,
    @required this.distanceInMeters,
  });
  @override
  String toString() => "Location(locationId: $locationId, label: $label, distanceInMeters: $distanceInMeters)";
}
