import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/blocs/movie_detail/movie_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieDetailCubit cubit;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    cubit = MovieDetailCubit(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  blocTest<MovieDetailCubit, MovieDetailState>(
    'should emit [Loading, Loaded] when fetching movies is successful',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => const Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(testMovieList));
      return cubit;
    },
    act: (cubit) => cubit.fetchMovieDetail(1),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(testMovieDetail, testMovieList),
    ],
    verify: (_) => verify(mockGetMovieDetail.execute(1)),
  );

  blocTest<MovieDetailCubit, MovieDetailState>(
    'should emit [Loading, Error] when fetching movies is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchMovieDetail(1),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (_) => verify(mockGetMovieDetail.execute(1)),
  );
}
