import 'package:streeto/common/constants.dart';
import 'package:streeto/persistences/favorites/favorites_persistence.dart';
import 'package:streeto/persistences/favorites/favorites_persistence_impl.dart';
import 'package:streeto/persistences/favorites/favorites_persistence_mock.dart';
import 'package:streeto/persistences/persistence.dart';
import 'package:streeto/persistences/preferences/preferences.dart';
import 'package:streeto/persistences/preferences/preferences_impl.dart';
import 'package:streeto/persistences/preferences/preferences_mock.dart';

class PersistencesLocator {
  static void initialize({bool mockServices = false}) {
    if (mockServices) {
      kGetIt.registerLazySingleton<FavoritesPersistence>(() => FavoritesPersistenceMock());
      kGetIt.registerLazySingleton<Preferences>(() => PreferencesMock());
    } else {
      kGetIt.registerLazySingleton<FavoritesPersistence>(() => FavoritesPersistenceImpl());
      kGetIt.registerLazySingleton<Preferences>(() => PreferencesImpl());
    }
  }

  static Future<void> clearAll() async {
    getPersistence<FavoritesPersistence>().clearPersistence();
    getPersistence<Preferences>().clearPersistence();
  }

  static T getPersistence<T extends Persistence>() => kGetIt.get<T>();
}
