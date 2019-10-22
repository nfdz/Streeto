import 'package:streeto/common/constants.dart';
import 'package:streeto/common/pair.dart';

class MapViewHelper {
  static const _kBaseUrl = "https://image.maps.api.here.com/mia/1.6/mapview";

  static String getMapImageUrl(double lat, double lon, int width, int height) {
    return Uri.encodeFull(
        "$_kBaseUrl?app_id=$kHereApiAppId&app_code=$kHereApiAppCode&c=$lat,$lon&w=$width&h=$height&pip");
  }

  static String getMapGroupImageUrl(List<Pair<double, double>> latLonPairs, int width, int height) {
    final latLonGroup = latLonPairs.map((pair) => "${pair.left},${pair.right}").join(",");
    return Uri.encodeFull(
        "$_kBaseUrl?app_id=$kHereApiAppId&app_code=$kHereApiAppCode&w=$width&h=$height&poi=$latLonGroup");
  }
}
