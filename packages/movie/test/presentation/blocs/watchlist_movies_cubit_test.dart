import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/blocs/watchlist_movies/watchlist_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMoviesCubit cubit;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    cubit = WatchlistMoviesCubit(mockGetWatchlistMovies);
  });

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should emit [Loading, Loaded] when fetching movies is successful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return cubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesLoaded(testMovieList),
    ],
    verify: (_) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'should emit [Loading, Error] when fetching movies is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [
      WatchlistMoviesLoading(),
      const WatchlistMoviesError('Database Failure'),
    ],
    verify: (_) => verify(mockGetWatchlistMovies.execute()),
  );
}
