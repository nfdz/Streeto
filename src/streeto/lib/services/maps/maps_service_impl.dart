import 'package:streeto/apis/map_view_helper.dart';
import 'package:streeto/common/pair.dart';
import 'package:streeto/services/maps/maps_service.dart';

class MapsServiceImpl extends MapsService {
  @override
  String getMapImageUrlForLocation(double lat, double lon, int width, int height) {
    return MapViewHelper.getMapImageUrl(lat, lon, width, height);
  }

  @override
  String getMapImageUrlForLocationGroup(List<Pair<double, double>> latLonPairs, int width, int height) {
    return MapViewHelper.getMapGroupImageUrl(latLonPairs, width, height);
  }
}
