import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'integration_tests.dart';

// To run the integration test: flutter drive --target=test_driver/app_integration_mock.dart
void main() {
  group('[Mock] Story 1 Tests: Main Screen', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test(IntegrationTestsStory1.testBadQueryTitle, () async {
      await IntegrationTestsStory1.testBadQuery(driver, badQuery: "BAD QUERY");
    });

    test(IntegrationTestsStory1.testOneResultQueryTitle, () async {
      await IntegrationTestsStory1.testOneResultQuery(
        driver,
        query: "99",
        locationId: "99",
        locationLabel: "Label 99",
      );
    });

    test(IntegrationTestsStory1.testLongListResultQueryTitle, () async {
      await IntegrationTestsStory1.testLongListResultQuery(
        driver,
        query: "0",
        lastOneLocationId: "90",
        lastOneLocationLabel: "Label 90",
      );
    });
  });
  group('[Mock] Story 2 Tests: Details Screen', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test(IntegrationTestsStory1.testBadQueryTitle, () async {
      await IntegrationTestsStory2.testTapGoToDetails(
        driver,
        query: "99",
        locationId: "99",
        expectedStreet: "St 99",
        expectedPostalCode: "99",
        expectedCoordinates: "37.3817273194, -122.08878861",
        expectedDistance: "10 km",
      );
    });
  });
  group('[Mock] Story 3 Tests: Add/Remove favorites', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test(IntegrationTestsStory3.testAddRemoveFavoriteTitle, () async {
      await IntegrationTestsStory3.testAddRemoveFavorite(
        driver,
        query: "99",
        locationId: "99",
      );
    });
  });
  group('[Mock] Story 4 Tests: Favorites screen', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test(IntegrationTestsStory4.testFavoritesScreenTitle, () async {
      await IntegrationTestsStory4.testFavoritesScreen(
        driver,
        query: "0",
        locationId1: "10",
        expectedLabel1: "Label 10",
        locationId2: "20",
        expectedLabel2: "Label 20",
      );
    });
  });
}
