import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/datasources/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late DatabaseHelper helper;

  setUpAll(() async {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;
    helper = DatabaseHelper();
  });

  test('should return 1 when insert watchlist successful', () async {
    final result = await helper.insertWatchlist(testMovieTable);

    expect(result, 1);
  });

  test('should return 1 when remove watchlist successful', () async {
    final result = await helper.removeWatchlist(testMovieTable);

    expect(result, 1);
  });

  test('should return movie map when data found from database', () async {
    await helper.insertWatchlist(testMovieTable);
    final result = await helper.getMovieById(1);

    expect(result, testMovieMap);
  });

  test('should return null when data not found from database', () async {
    await helper.removeWatchlist(testMovieTable);
    final result = await helper.getMovieById(1);

    expect(result, null);
  });

  test('should return list of movie map from database', () async {
    final result = await helper.getWatchlistMovies();

    expect(result, []);
  });

  tearDownAll(() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    deleteDatabase(databasePath);
  });
}
