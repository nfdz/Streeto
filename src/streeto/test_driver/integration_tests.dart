import 'package:flutter_driver/flutter_driver.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

class IntegrationTestsStory1 {
  static const String testBadQueryTitle = "Write a wrong query with no results";
  static Future<void> testBadQuery(FlutterDriver driver, {@required String badQuery}) async {
    final searchBoxFinder = find.byValueKey("main.search_box");
    await driver.tap(searchBoxFinder);
    await driver.enterText(badQuery);
    await driver.waitFor(find.text("main.empty_result"));
  }

  static const String testOneResultQueryTitle = "Write a query that gives only one result";
  static Future<void> testOneResultQuery(
    FlutterDriver driver, {
    @required String query,
    @required String locationId,
    @required String locationLabel,
  }) async {
    final searchBoxFinder = find.byValueKey("main.search_box");
    await driver.tap(searchBoxFinder);
    await driver.enterText(query);
    // Find entry and check its label
    final itemFinder = find.byValueKey(locationId);
    await driver.waitFor(itemFinder);
    final labelFinder = find.descendant(of: itemFinder, matching: find.text(locationLabel));
    await driver.waitFor(labelFinder);
    // Check there is only one label
    expect(await driver.getText(find.byValueKey("main.location_entry.label")), locationLabel);
  }

  static const String testLongListResultQueryTitle =
      "Write a query with a lot of results and scroll it to the last one";
  static Future<void> testLongListResultQuery(
    FlutterDriver driver, {
    @required String query,
    @required String lastOneLocationId,
    @required String lastOneLocationLabel,
  }) async {
    final searchBoxFinder = find.byValueKey("main.search_box");
    final listFinder = find.byValueKey("main.list_view");
    await driver.tap(searchBoxFinder);
    await driver.enterText(query);
    final itemFinder = find.byValueKey(lastOneLocationId);

    // Scroll to item
    await driver.scrollUntilVisible(
      listFinder,
      itemFinder,
      dyScroll: -300.0,
    );

    // Verify that the item contains the correct label
    final labelFinder = find.descendant(of: itemFinder, matching: find.byValueKey("main.location_entry.label"));
    expect(await driver.getText(labelFinder), lastOneLocationLabel);
  }
}

class IntegrationTestsStory2 {
  static const String testTapGoToDetailsTitle = "Write a query, tap it, go to details and check content is displayed";
  static Future<void> testTapGoToDetails(
    FlutterDriver driver, {
    @required String query,
    @required String locationId,
    @required String expectedStreet,
    @required String expectedPostalCode,
    @required String expectedCoordinates,
    @required String expectedDistance,
  }) async {
    final searchBoxFinder = find.byValueKey("main.search_box");
    await driver.tap(searchBoxFinder);
    await driver.enterText(query);
    final itemFinder = find.byValueKey(locationId);
    await driver.waitFor(itemFinder);
    await driver.tap(itemFinder);
    // Check test is in details screen
    await driver.waitFor(find.text("details.title"));
    // Check content
    expect(await driver.getText(find.byValueKey("details.street")), expectedStreet);
    expect(await driver.getText(find.byValueKey("details.postalCode")), expectedPostalCode);
    expect(await driver.getText(find.byValueKey("details.coordinates")), expectedCoordinates);
    expect(await driver.getText(find.byValueKey("details.distance")), expectedDistance);
    // Go back to main
    await _tryTapBack(driver);
  }
}

class IntegrationTestsStory3 {
  static const String testAddRemoveFavoriteTitle =
      "Write a query, tap it, go to details, add favorite, go back, go to details, check, remove favorite, go back, go to details again and check";
  static Future<void> testAddRemoveFavorite(
    FlutterDriver driver, {
    @required String query,
    @required String locationId,
  }) async {
    final searchBoxFinder = find.byValueKey("main.search_box");
    await driver.tap(searchBoxFinder);
    await driver.enterText(query);
    final itemFinder = find.byValueKey(locationId);
    // Go to details
    await driver.waitFor(itemFinder);
    await driver.tap(itemFinder);
    // Check test is in details screen
    await driver.waitFor(find.text("details.title"));
    // Check is not favorite
    expect(await driver.getText(find.byValueKey("details.favorite_btn.text")), "details.favorite_add");
    // Tap add favorite
    final favoriteBtnFinder = find.byValueKey("details.favorite_btn");
    await driver.tap(favoriteBtnFinder);
    // Go back
    await _tryTapBack(driver);
    // Go to details
    await driver.waitFor(itemFinder);
    await driver.tap(itemFinder);
    await driver.waitFor(find.text("details.title"));
    // Check is favorite
    expect(await driver.getText(find.byValueKey("details.favorite_btn.text")), "details.favorite_remove");
    // Tap remove favorite
    await driver.tap(favoriteBtnFinder);
    // Go back
    await _tryTapBack(driver);
    // Go to details
    await driver.waitFor(itemFinder);
    await driver.tap(itemFinder);
    await driver.waitFor(find.text("details.title"));
    // Check is not favorite
    expect(await driver.getText(find.byValueKey("details.favorite_btn.text")), "details.favorite_add");
    // Go back to main
    await _tryTapBack(driver);
  }
}

class IntegrationTestsStory4 {
  static const String testFavoritesScreenTitle = "Write a query, add some favorites, go to favorites, check content";
  static Future<void> testFavoritesScreen(
    FlutterDriver driver, {
    @required String query,
    @required String locationId1,
    @required String expectedLabel1,
    @required String locationId2,
    @required String expectedLabel2,
  }) async {
    final searchBoxFinder = find.byValueKey("main.search_box");
    await driver.tap(searchBoxFinder);
    await driver.enterText(query);
    // Go to details
    final itemFinder1 = find.byValueKey(locationId1);
    await driver.waitFor(itemFinder1);
    await driver.tap(itemFinder1);
    await driver.waitFor(find.text("details.title"));
    // Tap add favorite
    final favoriteBtnFinder = find.byValueKey("details.favorite_btn");
    await driver.tap(favoriteBtnFinder);
    // Go back
    await _tryTapBack(driver);
    // Go to details
    final itemFinder2 = find.byValueKey(locationId2);
    await driver.waitFor(itemFinder2);
    await driver.tap(itemFinder2);
    await driver.waitFor(find.text("details.title"));
    // Tap add favorite
    await driver.tap(favoriteBtnFinder);
    // Go back
    await _tryTapBack(driver);
    // Go to favorites
    final favoritesBtnFinder = find.byValueKey("main.favorites_fab");
    await driver.waitFor(favoritesBtnFinder);
    await driver.tap(favoritesBtnFinder);
    // Check screen
    await driver.waitFor(find.text("favorites.title"));
    // Label 1
    final label1Finder = find.descendant(of: itemFinder1, matching: find.byValueKey("favorites.location_entry.label"));
    final label1 = await driver.getText(label1Finder);
    expect(label1.contains(expectedLabel1), true);
    // Label 2
    final label2Finder = find.descendant(of: itemFinder2, matching: find.byValueKey("favorites.location_entry.label"));
    final label2 = await driver.getText(label2Finder);
    expect(label2.contains(expectedLabel2), true);
  }
}

// Workaround for: await driver.tap(find.pageBack());
Future<void> _tryTapBack(FlutterDriver driver) async {
  try {
    await driver.tap(find.byType("BackButton"));
  } catch (e) {
    await driver.tap(find.byType("CloseButton"));
  }
}
