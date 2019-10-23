import 'package:flutter/material.dart';
import 'package:streeto/common/texts/texts_provider.dart';

class MainTexts {
  static const String _kGlobalKey = "main";

  static String searchHint(BuildContext context) => _getText(context, "search_hint");
  static String permissionsNeeded(BuildContext context) => _getText(context, "permissions_needed");
  static String permissionsBtn(BuildContext context) => _getText(context, "permissions_btn");
  static String permissionsBtnAux(BuildContext context) => _getText(context, "permissions_btn_aux");
  static String locationError(BuildContext context) => _getText(context, "location_error");
  static String locationRetryBtn(BuildContext context) => _getText(context, "location_retry_btn");
  static String error(BuildContext context) => _getText(context, "error");
  static String emptyResult(BuildContext context) => _getText(context, "empty_result");
  static String favorites(BuildContext context) => _getText(context, "favorites");
  static String sortDistance(BuildContext context) => _getText(context, "sort_distance");
  static String sortName(BuildContext context) => _getText(context, "sort_name");
  static String sort(BuildContext context) => _getText(context, "sort");

  static String _getText(BuildContext context, String key) => TextsProvider.getText(context, "$_kGlobalKey.$key");
}
