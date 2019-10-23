class AppleMapsHelper {
  static String buildNavigationUrl(double lat, double lon) {
    final String mapsQueryRaw = "http://maps.apple.com/?q=$lat,$lon";
    return Uri.encodeFull(mapsQueryRaw);
  }
}
