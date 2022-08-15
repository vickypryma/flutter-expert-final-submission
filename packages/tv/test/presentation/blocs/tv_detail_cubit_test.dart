import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/presentation/blocs/tv_detail/tv_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvDetail, GetTvRecommendations])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late TvDetailCubit cubit;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    cubit = TvDetailCubit(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
    );
  });

  blocTest<TvDetailCubit, TvDetailState>(
    'should emit [Loading, Loaded] when fetching tv is successful',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => const Right(testTvDetail));
      when(mockGetTvRecommendations.execute(1))
          .thenAnswer((_) async => const Right(testTvList));
      return cubit;
    },
    act: (cubit) => cubit.fetchTvDetail(1),
    expect: () => [
      TvDetailLoading(),
      const TvDetailLoaded(testTvDetail, testTvList),
    ],
    verify: (_) {
      verify(mockGetTvDetail.execute(1));
      verify(mockGetTvRecommendations.execute(1));
    },
  );

  blocTest<TvDetailCubit, TvDetailState>(
    'should emit [Loading, Error] when fetching tv is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('failure')));
      when(mockGetTvRecommendations.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchTvDetail(1),
    expect: () => [
      TvDetailLoading(),
      const TvDetailError('failure'),
    ],
    verify: (_) {
      verify(mockGetTvDetail.execute(1));
      verify(mockGetTvRecommendations.execute(1));
    },
  );
}
