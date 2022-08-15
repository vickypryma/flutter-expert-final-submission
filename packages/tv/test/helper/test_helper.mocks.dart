// Mocks generated by Mockito 5.3.0 from annotations
// in tv/test/helper/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i19;
import 'dart:typed_data' as _i20;

import 'package:core/utils/failure.dart' as _i8;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/io_client.dart' as _i4;
import 'package:http/src/base_request.dart' as _i18;
import 'package:http/src/response.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i17;
import 'package:tv/data/datasources/db/tv_database_helper.dart' as _i16;
import 'package:tv/data/datasources/tv_local_data_source.dart' as _i12;
import 'package:tv/data/datasources/tv_remote_data_source.dart' as _i14;
import 'package:tv/data/models/episode_model.dart' as _i15;
import 'package:tv/data/models/tv_detail_model.dart' as _i3;
import 'package:tv/data/models/tv_model.dart' as _i13;
import 'package:tv/domain/entities/episode.dart' as _i11;
import 'package:tv/domain/entities/tv.dart' as _i9;
import 'package:tv/domain/entities/tv_detail.dart' as _i10;
import 'package:tv/domain/repositories/tv_repository.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvDetailResponse_1 extends _i1.SmartFake
    implements _i3.TvDetailResponse {
  _FakeTvDetailResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeIOStreamedResponse_2 extends _i1.SmartFake
    implements _i4.IOStreamedResponse {
  _FakeIOStreamedResponse_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i6.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getAiringTodayTv() =>
      (super.noSuchMethod(Invocation.method(#getAiringTodayTv, []),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Tv>>(
                  this, Invocation.method(#getAiringTodayTv, [])))) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getPopularTv() =>
      (super.noSuchMethod(Invocation.method(#getPopularTv, []),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Tv>>(
                  this, Invocation.method(#getPopularTv, [])))) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getTopRatedTv() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTv, []),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Tv>>(
                  this, Invocation.method(#getTopRatedTv, [])))) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, _i10.TvDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.TvDetail>(
                  this, Invocation.method(#getTvDetail, [id])))) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.TvDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Tv>>(
                  this, Invocation.method(#getTvRecommendations, [id])))) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> searchTv(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTv, [query]),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Tv>>(
                  this, Invocation.method(#searchTv, [query])))) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveTvWatchlist(
          _i10.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveTvWatchlist, [tv]),
              returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>(
                      this, Invocation.method(#saveTvWatchlist, [tv]))))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeTvWatchlist(
          _i10.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeTvWatchlist, [tv]),
              returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>(
                      this, Invocation.method(#removeTvWatchlist, [tv]))))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToTvWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToTvWatchlist, [id]),
          returnValue: _i7.Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getWatchlistTv() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTv, []),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Tv>>(
                  this, Invocation.method(#getWatchlistTv, [])))) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i11.Episode>>> getEpisodes(
          int? id, int? season) =>
      (super.noSuchMethod(Invocation.method(#getEpisodes, [id, season]),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, List<_i11.Episode>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i11.Episode>>(
                          this, Invocation.method(#getEpisodes, [id, season]))))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i11.Episode>>>);
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i12.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i13.TvModel? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tv]),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i13.TvModel? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i13.TvModel?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: _i7.Future<_i13.TvModel?>.value())
          as _i7.Future<_i13.TvModel?>);
  @override
  _i7.Future<List<_i13.TvModel>> getWatchlistTv() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTv, []),
          returnValue: _i7.Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
      as _i7.Future<List<_i13.TvModel>>);
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i14.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i13.TvModel>> getAiringTodayTv() => (super.noSuchMethod(
          Invocation.method(#getAiringTodayTv, []),
          returnValue: _i7.Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
      as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<List<_i13.TvModel>> getPopularTv() => (super.noSuchMethod(
          Invocation.method(#getPopularTv, []),
          returnValue: _i7.Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
      as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<List<_i13.TvModel>> getTopRatedTv() => (super.noSuchMethod(
          Invocation.method(#getTopRatedTv, []),
          returnValue: _i7.Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
      as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<_i3.TvDetailResponse> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
              returnValue: _i7.Future<_i3.TvDetailResponse>.value(
                  _FakeTvDetailResponse_1(
                      this, Invocation.method(#getTvDetail, [id]))))
          as _i7.Future<_i3.TvDetailResponse>);
  @override
  _i7.Future<List<_i13.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue:
                  _i7.Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
          as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<List<_i13.TvModel>> searchTv(String? query) => (super.noSuchMethod(
          Invocation.method(#searchTv, [query]),
          returnValue: _i7.Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
      as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<List<_i15.EpisodeModel>> getEpisodes(int? id, int? season) =>
      (super.noSuchMethod(Invocation.method(#getEpisodes, [id, season]),
          returnValue: _i7.Future<List<_i15.EpisodeModel>>.value(
              <_i15.EpisodeModel>[])) as _i7.Future<List<_i15.EpisodeModel>>);
}

/// A class which mocks [TvDatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDatabaseHelper extends _i1.Mock implements _i16.TvDatabaseHelper {
  MockTvDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i17.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: _i7.Future<_i17.Database?>.value())
          as _i7.Future<_i17.Database?>);
  @override
  _i7.Future<int> insertWatchlist(_i13.TvModel? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tv]),
          returnValue: _i7.Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i13.TvModel? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
          returnValue: _i7.Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: _i7.Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTv() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTv, []),
              returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i4.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.IOStreamedResponse> send(_i18.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: _i7.Future<_i4.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_2(
                      this, Invocation.method(#send, [request]))))
          as _i7.Future<_i4.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this, Invocation.method(#head, [url], {#headers: headers}))))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this, Invocation.method(#get, [url], {#headers: headers}))))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#post, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#post, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#put, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#put, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#patch, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#patch, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#delete, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#delete, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i20.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: _i7.Future<_i20.Uint8List>.value(_i20.Uint8List(0)))
          as _i7.Future<_i20.Uint8List>);
}
