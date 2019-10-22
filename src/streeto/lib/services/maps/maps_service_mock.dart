import 'package:streeto/common/pair.dart';
import 'package:streeto/services/maps/maps_service.dart';

class MapsServiceMock extends MapsService {
  @override
  String getMapImageUrlForLocation(double lat, double lon, int width, int height) {
    return "http://placekitten.com/$width/$height/?q=$lat";
  }

  @override
  String getMapImageUrlForLocationGroup(List<Pair<double, double>> latLonPairs, int width, int height) {
    return "http://placekitten.com/$width/$height/?q=${latLonPairs.hashCode}";
  }
}
