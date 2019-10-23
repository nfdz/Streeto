import 'package:flutter/material.dart';

enum ScreenType { REGULAR, LARGE }

ScreenType getScreenType(BuildContext context) {
  if (MediaQuery.of(context).size.shortestSide > 600) {
    return ScreenType.LARGE;
  } else {
    return ScreenType.REGULAR;
  }
}

// Common
double dimenLoadingSize(ScreenType screen) => screen == ScreenType.REGULAR ? 40 : 70;
EdgeInsets dimenAlertContentPadding(ScreenType screen) =>
    screen == ScreenType.REGULAR ? const EdgeInsets.all(18.0) : const EdgeInsets.all(18.0);
double dimenAlertContentImageSize(ScreenType screen) => screen == ScreenType.REGULAR ? 90 : 220;
EdgeInsets dimenAlertContentTextPadding(ScreenType screen) =>
    screen == ScreenType.REGULAR ? const EdgeInsets.all(18.0) : const EdgeInsets.all(40.0);
EdgeInsets dimenMapPadding(ScreenType screen) =>
    screen == ScreenType.REGULAR ? const EdgeInsets.all(8.0) : const EdgeInsets.all(16.0);

// Main
EdgeInsets dimenMainLocationEntryPadding(ScreenType screen) => screen == ScreenType.REGULAR
    ? const EdgeInsets.symmetric(horizontal: 38)
    : const EdgeInsets.symmetric(horizontal: 120, vertical: 4);
EdgeInsets dimenMainSearchBoxPadding(ScreenType screen) => screen == ScreenType.REGULAR
    ? const EdgeInsets.symmetric(horizontal: 22)
    : const EdgeInsets.symmetric(horizontal: 90);
EdgeInsets dimenMainListViewPadding(ScreenType screen) => screen == ScreenType.REGULAR
    ? const EdgeInsets.only(top: 16, bottom: 80)
    : const EdgeInsets.only(top: 16, bottom: 80);

// Details
EdgeInsets dimenDetailsTextContentPadding(ScreenType screen) => screen == ScreenType.REGULAR
    ? const EdgeInsets.symmetric(vertical: 12, horizontal: 28)
    : const EdgeInsets.symmetric(vertical: 30, horizontal: 60);

// Favorites
EdgeInsets dimenFavsListViewPadding(ScreenType screen) =>
    screen == ScreenType.REGULAR ? const EdgeInsets.symmetric(vertical: 16) : const EdgeInsets.symmetric(vertical: 16);
EdgeInsets dimenFavsLocationEntryPadding(ScreenType screen) => screen == ScreenType.REGULAR
    ? const EdgeInsets.symmetric(horizontal: 38)
    : const EdgeInsets.symmetric(horizontal: 100, vertical: 4);
