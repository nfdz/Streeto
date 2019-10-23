import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streeto/persistences/preferences/preferences.dart';

class PreferencesImpl extends Preferences {
  final Logger _logger = Logger("PreferencesImpl");
  static const String _kSuggestionsSortKey = "suggestions_sort";
  static const String _kNavigationKey = "navigation_provider";

  @override
  Future<void> clearPersistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_kSuggestionsSortKey);
    prefs.remove(_kNavigationKey);
  }

  @override
  Future<SuggestionsSort> getSuggestionsSort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final sortIndex = prefs.getInt(_kSuggestionsSortKey);
      SuggestionsSort sort =
          sortIndex != null ? SuggestionsSort.values.firstWhere((sort) => sort.index == sortIndex, orElse: null) : null;
      return sort != null ? sort : kDefaultSuggestionsSort;
    } catch (e) {
      _logger.fine(e);
    }
    return kDefaultSuggestionsSort;
  }

  @override
  Future<void> setSuggestionsSort(SuggestionsSort sort) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kSuggestionsSortKey, sort.index);
  }

  @override
  Future<NavigationProvider> getNavigationProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final navIndex = prefs.getInt(_kNavigationKey);
      NavigationProvider nav = navIndex != null
          ? NavigationProvider.values.firstWhere((sort) => sort.index == navIndex, orElse: null)
          : null;
      return nav;
    } catch (e) {
      _logger.fine(e);
    }
    return null;
  }

  @override
  Future<void> setNavigationProvider(NavigationProvider nav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kNavigationKey, nav.index);
  }
}
