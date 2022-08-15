import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/blocs/top_rated_movies/top_rated_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesCubit cubit;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    cubit = TopRatedMoviesCubit(mockGetTopRatedMovies);
  });

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'should emit [Loading, Loaded] when fetching movies is successful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return cubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesLoaded(testMovieList),
    ],
    verify: (_) => verify(mockGetTopRatedMovies.execute()),
  );

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'should emit [Loading, Error] when fetching movies is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMoviesLoading(),
      const TopRatedMoviesError('Server Failure'),
    ],
    verify: (_) => verify(mockGetTopRatedMovies.execute()),
  );
}
