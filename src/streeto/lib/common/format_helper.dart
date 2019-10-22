class FormatHelper {
  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters == null) {
      return "";
    } else if (distanceInMeters > 999) {
      final distanceInKilometers = distanceInMeters / 1000;
      return "${distanceInKilometers.toStringAsFixed(0)} km";
    } else {
      return "${distanceInMeters.toStringAsFixed(0)} m";
    }
  }
}
