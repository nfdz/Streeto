import 'package:streeto/persistences/persistence.dart';

abstract class Preferences extends Persistence {
  Future<SuggestionsSort> getSuggestionsSort();
  Future<void> setSuggestionsSort(SuggestionsSort sort);
  Future<NavigationProvider> getNavigationProvider();
  Future<void> setNavigationProvider(NavigationProvider nav);
}

enum SuggestionsSort { BY_NAME, BY_DISTANCE }
const kDefaultSuggestionsSort = SuggestionsSort.BY_DISTANCE;

enum NavigationProvider { HERE, GOOGLE, APPLE }
