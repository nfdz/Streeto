import 'package:flutter/material.dart';
import 'package:streeto/common/texts/texts_provider.dart';

class GlobalTexts {
  static String appName(BuildContext context) => TextsProvider.getText(context, "app_name");
  static String mapClick(BuildContext context) => TextsProvider.getText(context, "map_click");
  static String navigationProvider(BuildContext context) => TextsProvider.getText(context, "navigation_provider");
  static String navigationGoogle(BuildContext context) => TextsProvider.getText(context, "navigation_google");
  static String navigationHere(BuildContext context) => TextsProvider.getText(context, "navigation_here");
  static String navigationApple(BuildContext context) => TextsProvider.getText(context, "navigation_apple");
}
