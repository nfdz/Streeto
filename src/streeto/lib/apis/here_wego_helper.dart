class HereWeGoHelper {
  static String buildNavigationUrl(double fromLat, double fromLon, double toLat, double toLon) {
    return Uri.encodeFull("https://wego.here.com/directions/mix/:$fromLat,$fromLon/-:$toLat,$toLon");
  }

  static String buildMapUrl(double lat, double lon) {
    return Uri.encodeFull("https://wego.here.com/directions/mix/:$lat,$lon/");
  }
}
