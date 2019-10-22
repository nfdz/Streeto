import 'package:flutter/material.dart';
import 'package:streeto/common/texts/texts_provider.dart';

class FavoritesTexts {
  static const String _kGlobalKey = "favorites";

  static String title(BuildContext context) => _getText(context, "title");

  static String _getText(BuildContext context, String key) => TextsProvider.getText(context, "$_kGlobalKey.$key");
}
