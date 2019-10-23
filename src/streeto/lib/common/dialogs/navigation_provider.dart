import 'package:flutter/material.dart';
import 'package:streeto/common/texts/global_texts.dart';
import 'package:streeto/persistences/preferences/preferences.dart';

Future<NavigationProvider> askNavigationDialog(BuildContext context) async {
  return await showDialog<NavigationProvider>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(GlobalTexts.navigationProvider(context)),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, NavigationProvider.HERE),
              child: Text(GlobalTexts.navigationHere(context)),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, NavigationProvider.GOOGLE),
              child: Text(GlobalTexts.navigationGoogle(context)),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, NavigationProvider.APPLE),
              child: Text(GlobalTexts.navigationApple(context)),
            ),
          ],
        );
      });
}
