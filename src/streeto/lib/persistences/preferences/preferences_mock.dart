import 'package:streeto/common/constants.dart';
import 'package:streeto/persistences/preferences/preferences.dart';

class PreferencesMock extends Preferences {
  SuggestionsSort _sort = kDefaultSuggestionsSort;

  @override
  Future<void> clearPersistence() async {
    doFakeDelayIfNeeded();
    _sort = kDefaultSuggestionsSort;
  }

  @override
  Future<SuggestionsSort> getSuggestionsSort() async {
    doFakeDelayIfNeeded();
    return _sort;
  }

  @override
  Future<void> setSuggestionsSort(SuggestionsSort sort) async {
    doFakeDelayIfNeeded();
    _sort = sort;
  }
}
