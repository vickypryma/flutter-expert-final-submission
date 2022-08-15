import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/blocs/now_playing_movies/now_playing_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesCubit cubit;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    cubit = NowPlayingMoviesCubit(mockGetNowPlayingMovies);
  });

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'should emit [Loading, Loaded] when fetching movies is successful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return cubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesLoaded(testMovieList),
    ],
    verify: (_) => verify(mockGetNowPlayingMovies.execute()),
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'should emit [Loading, Error] when fetching movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('Server Failure'),
    ],
    verify: (_) => verify(mockGetNowPlayingMovies.execute()),
  );
}
