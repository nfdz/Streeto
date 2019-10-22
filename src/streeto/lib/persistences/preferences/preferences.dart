import 'package:streeto/persistences/persistence.dart';

abstract class Preferences extends Persistence {
  Future<SuggestionsSort> getSuggestionsSort();
  Future<void> setSuggestionsSort(SuggestionsSort sort);
}

enum SuggestionsSort { BY_NAME, BY_DISTANCE }
const kDefaultSuggestionsSort = SuggestionsSort.BY_DISTANCE;
