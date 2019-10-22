import 'package:streeto/common/constants.dart';
import 'package:streeto/services/locations/locations_service.dart';
import 'package:streeto/services/locations/locations_service_impl.dart';
import 'package:streeto/services/locations/locations_service_mock.dart';
import 'package:streeto/services/maps/maps_service.dart';
import 'package:streeto/services/maps/maps_service_impl.dart';
import 'package:streeto/services/maps/maps_service_mock.dart';
import 'package:streeto/services/service.dart';

class ServicesLocator {
  static void initialize({bool mockServices = false, bool mockLocation = false}) {
    if (mockServices) {
      kGetIt.registerLazySingleton<LocationsService>(() => LocationsServiceMock());
      kGetIt.registerLazySingleton<MapsService>(() => MapsServiceMock());
    } else {
      kGetIt.registerLazySingleton<LocationsService>(() => LocationsServiceImpl(mockLocation: mockLocation));
      kGetIt.registerLazySingleton<MapsService>(() => MapsServiceImpl());
    }
  }

  static T getService<T extends Service>() => kGetIt.get<T>();
}
