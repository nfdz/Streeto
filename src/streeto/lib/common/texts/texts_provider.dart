import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class TextsProvider {
  static bool dummy = false;

  static getText(BuildContext context, String key) => !dummy ? FlutterI18n.translate(context, key) : key;
}
