import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockTvLocalDataSource mockTvLocalDataSource;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late TvRepository repository;

  setUp(() {
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockTvRemoteDataSource,
      localDataSource: mockTvLocalDataSource,
    );
  });

  group('get airing today tv series', () {
    test('should return Tv list when calling remote data is success', () async {
      // arrange
      when(mockTvRemoteDataSource.getAiringTodayTv())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getAiringTodayTv();
      // assert
      verify(mockTvRemoteDataSource.getAiringTodayTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test('should return ServerFailure when calling remote data is failed',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getAiringTodayTv())
          .thenThrow(ServerException());
      // act
      final result = await repository.getAiringTodayTv();
      // assert
      verify(mockTvRemoteDataSource.getAiringTodayTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return ConnectionFailure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getAiringTodayTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAiringTodayTv();
      // assert
      verify(mockTvRemoteDataSource.getAiringTodayTv());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get popular tv series', () {
    test('should return Tv list when calling remote data is success', () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      verify(mockTvRemoteDataSource.getPopularTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test('should return ServerFailure when calling remote data is failed',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return ConnectionFailure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTv();
      // assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get top rated tv series', () {
    test('should return Tv list when calling remote data is success', () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test('should return ServerFailure when calling remote data is failed',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return ConnectionFailure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get tv series detail', () {
    const tId = 1;

    test('should return TvDetail when calling remote data is success',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => testTvDetailResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result, const Right(testTvDetail));
    });

    test('should return ServerFailure when calling remote data is failed',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get tv series recommendations', () {
    const tId = 1;

    test('should return Tv list when calling remote data is success', () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test('should return ServerFailure when calling remote data is failed',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return ConnectionFailure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('search tv series', () {
    const tQuery = 'test';

    test('should return Tv list when calling remote data is success', () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });

    test('should return ServerFailure when calling remote data is failed',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return ConnectionFailure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get watchlist tv series', () {
    test('should return tv series list', () async {
      // arrange
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });
  });

  group('get watchlist status', () {
    const tId = 1;

    test('should return status whether data is found', () async {
      // arrange
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToTvWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlist(testTvModel))
          .thenAnswer((_) async => 'Removed from Watchlist');
      // act
      final result = await repository.removeTvWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlist(testTvModel))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTvWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlist(testTvModel))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTvWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlist(testTvModel))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTvWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('get episodes', () {
    const tId = 1;
    const tSeason = 1;

    test('should return season detail when calling remote data successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getEpisodes(tId, tSeason))
          .thenAnswer((_) async => testEpisodeModelList);
      // act
      final result = await repository.getEpisodes(tId, tSeason);
      // assert
      final resultList = result.getOrElse(() => []);
      verify(mockTvRemoteDataSource.getEpisodes(tId, tSeason));
      expect(resultList, testEpisodeList);
    });

    test('should return ServerFailure when calling remote data unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getEpisodes(tId, tSeason))
          .thenThrow(ServerException());
      // act
      final result = await repository.getEpisodes(tId, tSeason);
      // assert
      verify(mockTvRemoteDataSource.getEpisodes(tId, tSeason));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return ConnectionFailure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getEpisodes(tId, tSeason))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getEpisodes(tId, tSeason);
      // assert
      verify(mockTvRemoteDataSource.getEpisodes(tId, tSeason));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
