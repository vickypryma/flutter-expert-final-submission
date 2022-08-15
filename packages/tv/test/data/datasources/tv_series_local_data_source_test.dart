import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockTvDatabaseHelper mockTvDatabaseHelper;
  late TvLocalDataSourceImpl dataSource;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockTvDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvModel))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvModel);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvModel))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvModel);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvModel))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvModel);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvModel))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvModel);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get series by id', () {
    const tId = 1;

    test('should return tv series table when data is found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvModel);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockTvDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, testTvModelList);
    });
  });
}
