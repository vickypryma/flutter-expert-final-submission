import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/blocs/popular_movies/popular_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesCubit cubit;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    cubit = PopularMoviesCubit(mockGetPopularMovies);
  });

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'should emit [Loading, Loaded] when fetching movies is successful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return cubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesLoaded(testMovieList),
    ],
    verify: (_) => verify(mockGetPopularMovies.execute()),
  );

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'should emit [Loading, Error] when fetching movies is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () => [
      PopularMoviesLoading(),
      const PopularMoviesError('Server Failure'),
    ],
    verify: (_) => verify(mockGetPopularMovies.execute()),
  );
}
