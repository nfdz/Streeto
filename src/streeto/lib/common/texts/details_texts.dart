import 'package:flutter/material.dart';
import 'package:streeto/common/texts/texts_provider.dart';

class DetailsTexts {
  static const String _kGlobalKey = "details";

  static String title(BuildContext context) => _getText(context, "title");
  static String loadRetry(BuildContext context) => _getText(context, "load_retry");
  static String loadError(BuildContext context) => _getText(context, "load_error");
  static String street(BuildContext context) => _getText(context, "street");
  static String postalCode(BuildContext context) => _getText(context, "postal_code");
  static String coordinates(BuildContext context) => _getText(context, "coordinates");
  static String distance(BuildContext context) => _getText(context, "distance");
  static String favoriteAdd(BuildContext context) => _getText(context, "favorite_add");
  static String favoriteRemove(BuildContext context) => _getText(context, "favorite_remove");

  static String _getText(BuildContext context, String key) => TextsProvider.getText(context, "$_kGlobalKey.$key");
}
