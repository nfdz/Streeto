import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

const String kAppName = "What's going around?";

// Colors
const Color kPrimaryColor = Color(0xfff0eff2);
const Color kBackgroundColor = kPrimaryColor;
const Color kAccentColor = Color(0xff1dd861);
const Color kHintColor = Color(0xff5b5b5c);

// Fonts
const String kNunitoFont = "Nunito";

// Image assets
const String kPolicemanImageAsset = "assets/images/policeman.png";
const String kMapLocationImageAsset = "assets/images/map-location.png";
const String kErrorCircleImageAsset = "assets/images/error-circle.png";
const String kEmptyBoxImageAsset = "assets/images/empty-box.png";

// Texts styles
const TextStyle kHeaderTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 24,
  fontWeight: FontWeight.bold,
  fontFamily: kNunitoFont,
);
const TextStyle kContentTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
);
const TextStyle kSmallBoldTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

// Animations
const kFadeImageDuration = Duration(milliseconds: 400);

// Cache
const Duration kCacheMaxAgeDuration = const Duration(days: 7);
const int kCacheMaxImgs = 200;

// Global service locator
final GetIt kGetIt = GetIt();

// DB settings
const String kDbPath = "streeto.db";
const int kDbVersion = 1;

// API settings
const String kHereApiAppId = "{API_APP_ID_HERE}";
const String kHereApiAppCode = "{API_APP_CODE_HERE}";

// Mock settings
const double kMockLocationLat = 37.3817273194;
const double kMockLocationLon = -122.08878861;
const bool kMockFakeDelay = true;
const Duration kMockFakeDelayDuration = Duration(milliseconds: 600);
Future<void> doFakeDelayIfNeeded() async {
  if (kMockFakeDelay) {
    await Future.delayed(kMockFakeDelayDuration);
  }
}
