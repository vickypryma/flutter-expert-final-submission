import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tv/data/datasources/db/tv_database_helper.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late TvDatabaseHelper helper;

  setUpAll(() async {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;
    helper = TvDatabaseHelper();
  });

  test('should return 1 when insert watchlist successful', () async {
    final result = await helper.insertWatchlist(testTvModel);

    expect(result, 1);
  });

  test('should return 1 when remove watchlist successful', () async {
    final result = await helper.removeWatchlist(testTvModel);

    expect(result, 1);
  });

  test('should return tv series map when data found from database', () async {
    await helper.insertWatchlist(testTvModel);
    final result = await helper.getTvById(1);

    expect(result, testTvMap);
  });

  test('should return null when data not found from database', () async {
    await helper.removeWatchlist(testTvModel);
    final result = await helper.getTvById(1);

    expect(result, null);
  });

  test('should return list of movie map from database', () async {
    final result = await helper.getWatchlistTv();

    expect(result, []);
  });

  tearDownAll(() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/tv.db';

    deleteDatabase(databasePath);
  });
}
