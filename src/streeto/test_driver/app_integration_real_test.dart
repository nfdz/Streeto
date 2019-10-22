import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'integration_tests.dart';

// To run the integration test: flutter drive --target=test_driver/app_integration_real.dart
void main() {
  group('[Real] Story 1 Tests: Main Screen', () {
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
        query: "UK, London, SW1A 2AA, London, 10 Downing Street",
        locationId: "NT_lWsc8knsFwVitNTFX88zmA_xAD",
        locationLabel: "UK, London, SW1A 2AA, London, 10 Downing Street",
      );
    });

    test(IntegrationTestsStory1.testLongListResultQueryTitle, () async {
      await IntegrationTestsStory1.testLongListResultQuery(
        driver,
        query: "University, USA",
        lastOneLocationId: "NT_iBBQcEJYStJ8cLTEnUu74A",
        lastOneLocationLabel: "USA, CA, Menlo Park, University Heights",
      );
    });
  });
  group('[Real] Story 2 Tests: Details Screen', () {
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
      await IntegrationTestsStory2.testTapGoToDetails(driver,
          query: "UK, London, SW1A 2AA, London, 10 Downing Street",
          locationId: "NT_lWsc8knsFwVitNTFX88zmA_xAD",
          expectedStreet: "Downing Street",
          expectedPostalCode: "SW1A 2AA",
          expectedCoordinates: "51.50341, -0.12765",
          expectedDistance: "8638 km");
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
        query: "UK, London, SW1A 2AA, London, 10 Downing Street",
        locationId: "NT_lWsc8knsFwVitNTFX88zmA_xAD",
      );
    });
  });
  group('[Real] Story 4 Tests: Favorites screen', () {
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
        query: "University, USA",
        locationId1: "NT_QBKR9hvZ4tRRnmf2.wiX9B",
        expectedLabel1: "USA, CA, Los Altos, University Ave",
        locationId2: "NT_tcbEhD4PHmdz6.LefZf--C",
        expectedLabel2: "USA, CA, Mountain View, Castro City, University Ave",
      );
    });
  });
}
