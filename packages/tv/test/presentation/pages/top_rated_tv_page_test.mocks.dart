// Mocks generated by Mockito 5.3.0 from annotations
// in tv/test/presentation/pages/top_rated_tv_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart' as _i2;
import 'package:tv/presentation/blocs/top_rated_tv/top_rated_tv_cubit.dart'
    as _i3;

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

class _FakeGetTopRatedTv_0 extends _i1.SmartFake implements _i2.GetTopRatedTv {
  _FakeGetTopRatedTv_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTopRatedTvState_1 extends _i1.SmartFake
    implements _i3.TopRatedTvState {
  _FakeTopRatedTvState_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TopRatedTvCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedTvCubit extends _i1.Mock implements _i3.TopRatedTvCubit {
  MockTopRatedTvCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedTv get getTopRatedTv =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedTv),
              returnValue:
                  _FakeGetTopRatedTv_0(this, Invocation.getter(#getTopRatedTv)))
          as _i2.GetTopRatedTv);
  @override
  _i3.TopRatedTvState get state => (super.noSuchMethod(
          Invocation.getter(#state),
          returnValue: _FakeTopRatedTvState_1(this, Invocation.getter(#state)))
      as _i3.TopRatedTvState);
  @override
  _i4.Stream<_i3.TopRatedTvState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: _i4.Stream<_i3.TopRatedTvState>.empty())
          as _i4.Stream<_i3.TopRatedTvState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i4.Future<void> fetchTopRatedTv() => (super.noSuchMethod(
      Invocation.method(#fetchTopRatedTv, []),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
  @override
  void emit(_i3.TopRatedTvState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i5.Change<_i3.TopRatedTvState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
}
