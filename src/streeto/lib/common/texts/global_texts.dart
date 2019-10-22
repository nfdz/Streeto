import 'package:flutter/material.dart';
import 'package:streeto/common/texts/texts_provider.dart';

class GlobalTexts {
  static String appName(BuildContext context) => TextsProvider.getText(context, "app_name");
}
