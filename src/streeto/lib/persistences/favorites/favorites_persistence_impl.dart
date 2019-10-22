import 'dart:io';

import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/model/location_details.dart';
import 'package:streeto/persistences/favorites/favorites_persistence.dart';

class FavoritesPersistenceImpl extends FavoritesPersistence {
  static const String _kFavoritesStore = "favorites";

  static const String _kRecordStreet = "street";
  static const String _kRecordPostalCode = "postalCode";
  static const String _kRecordLabel = "label";
  static const String _kRecordLat = "lat";
  static const String _kRecordLon = "lon";
  static const String _kRecordLocationId = "locationId";

  Database _db;

  Future<void> _openDbIfNeeded() async {
    if (_db == null) {
      DatabaseFactory dbFactory = databaseFactoryIo;
      Directory appDocDir = await PathProvider.getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      _db = await dbFactory.openDatabase("$appDocPath/$kDbPath");
    }
  }

  @override
  Future<void> clearPersistence() async {
    await _openDbIfNeeded();
    var store = stringMapStoreFactory.store(_kFavoritesStore);
    await store.delete(_db);
  }

  @override
  Future<List<LocationDetails>> getFavorites() async {
    await _openDbIfNeeded();
    var store = stringMapStoreFactory.store(_kFavoritesStore);
    var records = await store.find(_db);
    return records.map((record) => _recordToDetails(record.value)).toList();
  }

  @override
  Future<bool> isFavorite(String locationId) async {
    await _openDbIfNeeded();
    var store = stringMapStoreFactory.store(_kFavoritesStore);
    final record = await store.record(locationId).get(_db);
    return record != null;
  }

  @override
  Future<void> addFavorite(LocationDetails location) async {
    await _openDbIfNeeded();
    var store = stringMapStoreFactory.store(_kFavoritesStore);
    await store.record(location.locationId).put(_db, _detailsToRecord(location));
  }

  @override
  Future<void> removeFavorite(String locationId) async {
    await _openDbIfNeeded();
    var store = stringMapStoreFactory.store(_kFavoritesStore);
    await store.record(locationId).delete(_db);
  }

  Map<String, dynamic> _detailsToRecord(LocationDetails details) {
    return {
      _kRecordStreet: details.street,
      _kRecordPostalCode: details.postalCode,
      _kRecordLat: details.lat,
      _kRecordLon: details.lon,
      _kRecordLabel: details.label,
      _kRecordLocationId: details.locationId
    };
  }

  LocationDetails _recordToDetails(Map<String, dynamic> record) {
    return LocationDetails(
      label: record[_kRecordLabel],
      street: record[_kRecordStreet],
      postalCode: record[_kRecordPostalCode],
      lat: record[_kRecordLat],
      lon: record[_kRecordLon],
      locationId: record[_kRecordLocationId],
    );
  }
}
