class GoogleMapsHelper {
  static String buildNavigationUrl(double lat, double lon) {
    final String mapsQueryRaw = "https://www.google.com/maps/search/?api=1&query=$lat,$lon";
    return Uri.encodeFull(mapsQueryRaw);
  }
}
