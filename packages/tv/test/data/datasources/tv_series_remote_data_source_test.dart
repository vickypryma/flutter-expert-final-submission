import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/season_response.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../helper/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;
  late String tvSeriesResponse;
  late List<TvModel> tvSeriesList;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TvRemoteDataSourceImpl(client: mockIOClient);
    tvSeriesResponse = readJson('dummy_data/tv_series_response.json');
    tvSeriesList = TvResponse.fromJson(json.decode(tvSeriesResponse)).tvList;
  });

  group('get Airing Today TV Series', () {
    test(
      'should return list of TV Series Model when the response code is 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
            .thenAnswer((_) async => http.Response(tvSeriesResponse, 200));
        // act
        final result = await dataSource.getAiringTodayTv();
        // assert
        expect(result, equals(tvSeriesList));
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getAiringTodayTv();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Popular TV Series', () {
    test(
      'should return list of TV Series Model when the response code is 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
            .thenAnswer((_) async => http.Response(tvSeriesResponse, 200));
        // act
        final result = await dataSource.getPopularTv();
        // assert
        expect(result, equals(tvSeriesList));
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getPopularTv();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Top Rated TV Series', () {
    test(
      'should return list of TV Series Model when the response code is 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
            .thenAnswer((_) async => http.Response(tvSeriesResponse, 200));
        // act
        final result = await dataSource.getTopRatedTv();
        // assert
        expect(result, equals(tvSeriesList));
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTopRatedTv();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get TV Series Detail', () {
    const tId = 1;
    final tSeriesDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));

    test(
      'should return TV Series Detail when response code is 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
            .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_series_detail.json'), 200));
        // act
        final result = await dataSource.getTvDetail(tId);
        // assert
        expect(result, equals(tSeriesDetail));
      },
    );

    test(
      'should throw a ServerException when response code is not 200',
      () {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvDetail(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get TV Series Recommendations', () {
    const tId = 1;

    test(
      'should return list of TV Series Model when response code is 200',
      () async {
        // arrange
        when(mockIOClient
                .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
            .thenAnswer((_) async => http.Response(tvSeriesResponse, 200));
        // act
        final result = await dataSource.getTvRecommendations(tId);
        // assert
        expect(result, equals(tvSeriesList));
      },
    );

    test(
      'should throw a ServerException when response code is not 200',
      () {
        // arrange
        when(mockIOClient
                .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvRecommendations(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('search TV Series', () {
    const tQuery = 'test';

    test(
      'should return list of TV Series Model when response code is 200',
      () async {
        // arrange
        when(mockIOClient
                .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
            .thenAnswer((_) async => http.Response(tvSeriesResponse, 200));
        // act
        final result = await dataSource.searchTv(tQuery);
        // assert
        expect(result, equals(tvSeriesList));
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () {
        // arrange
        when(mockIOClient
                .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.searchTv(tQuery);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get episodes', () {
    const tId = 1;
    const tSeason = 1;
    final tSeasonResponse = readJson('dummy_data/season.json');
    final tEpisodeList =
        SeasonResponse.fromJson(json.decode(tSeasonResponse)).episodeList;

    test('should return season model when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeason?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/season.json'), 200));
      // act
      final result = await dataSource.getEpisodes(tId, tSeason);
      expect(result, equals(tEpisodeList));
    });

    test('should throw a ServerException when response code is not 200', () {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeason?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getEpisodes(tId, tSeason);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
