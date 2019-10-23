import 'package:streeto/common/constants.dart';
import 'package:streeto/persistences/preferences/preferences.dart';

class PreferencesMock extends Preferences {
  SuggestionsSort _sort = kDefaultSuggestionsSort;
  NavigationProvider _nav;

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

  @override
  Future<NavigationProvider> getNavigationProvider() async {
    doFakeDelayIfNeeded();
    return _nav;
  }

  @override
  Future<void> setNavigationProvider(NavigationProvider nav) async {
    doFakeDelayIfNeeded();
    _nav = nav;
  }
}
