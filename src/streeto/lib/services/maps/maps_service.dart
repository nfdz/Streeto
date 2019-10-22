import 'package:streeto/common/pair.dart';
import 'package:streeto/services/service.dart';

abstract class MapsService extends Service {
  String getMapImageUrlForLocation(double lat, double lon, int width, int height);
  String getMapImageUrlForLocationGroup(List<Pair<double, double>> latLonPairs, int width, int height);
}
