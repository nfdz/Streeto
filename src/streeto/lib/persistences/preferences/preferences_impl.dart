import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streeto/persistences/preferences/preferences.dart';

class PreferencesImpl extends Preferences {
  static const String _kSuggestionsSortKey = "suggestions_sort";
  final Logger _logger = Logger("PreferencesImpl");

  @override
  Future<void> clearPersistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_kSuggestionsSortKey);
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
}
