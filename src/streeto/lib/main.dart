import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/common/texts/texts_provider.dart';
import 'package:streeto/persistences/persistences_locator.dart';
import 'package:streeto/screens/details/details_screen.dart';
import 'package:streeto/screens/favorites/favorites_screen.dart';
import 'package:streeto/screens/main/main_screen.dart';
import 'package:streeto/services/services_locator.dart';

void main({
  bool mockServices = false,
  bool mockTexts = false,
  bool mockLocation = false,
}) {
  _setupLogger();
  ServicesLocator.initialize(mockServices: mockServices, mockLocation: mockLocation);
  PersistencesLocator.initialize(mockServices: mockServices);
  TextsProvider.dummy = mockTexts;
  runApp(StreetoApp());
}

void _setupLogger() {
  if (kReleaseMode) {
    Logger.root.level = Level.WARNING;
    Logger.root.onRecord.listen((LogRecord rec) {
      // TBD
    });
  } else {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      log(
        rec.message,
        level: rec.level.value,
        name: rec.loggerName,
        time: rec.time,
        stackTrace: rec.stackTrace,
        error: rec.error,
        sequenceNumber: rec.sequenceNumber,
        zone: rec.zone,
      );
    });
  }
}

class StreetoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: _buildAppTheme(),
      initialRoute: MainScreen.route,
      routes: {
        MainScreen.route: (context) => MainScreen(),
        DetailsScreen.route: (context) => DetailsScreen(),
        FavoritesScreen.route: (context) => FavoritesScreen(),
      },
      localizationsDelegates: [
        FlutterI18nDelegate(useCountryCode: false, fallbackFile: "en", path: "assets/locales"),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es'),
      ],
    );
  }

  ThemeData _buildAppTheme() => ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        scaffoldBackgroundColor: kBackgroundColor,
        buttonTheme: ThemeData.light().buttonTheme.copyWith(highlightColor: kAccentColor),
        highlightColor: kAccentColor,
        cursorColor: Colors.black,
        textSelectionColor: kAccentColor,
        textSelectionHandleColor: Colors.black,
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              elevation: 0,
              color: kBackgroundColor,
              iconTheme: IconThemeData(color: Colors.black),
            ),
      );
}
