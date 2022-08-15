import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/presentation/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/presentation/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_page_test.mocks.dart';
import 'popular_movies_page_test.mocks.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([NowPlayingMoviesCubit])
void main() {
  late MockNowPlayingMoviesCubit nowPlayingMoviesCubit;
  late MockPopularMoviesCubit popularMoviesCubit;
  late MockTopRatedMoviesCubit topRatedMoviesCubit;

  setUp(() {
    nowPlayingMoviesCubit = MockNowPlayingMoviesCubit();
    popularMoviesCubit = MockPopularMoviesCubit();
    topRatedMoviesCubit = MockTopRatedMoviesCubit();
    when(nowPlayingMoviesCubit.stream).thenAnswer((_) => const Stream.empty());
    when(popularMoviesCubit.stream).thenAnswer((_) => const Stream.empty());
    when(topRatedMoviesCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesCubit>.value(value: nowPlayingMoviesCubit),
        BlocProvider<PopularMoviesCubit>.value(value: popularMoviesCubit),
        BlocProvider<TopRatedMoviesCubit>.value(value: topRatedMoviesCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(nowPlayingMoviesCubit.state).thenReturn(NowPlayingMoviesLoading());
      when(popularMoviesCubit.state).thenReturn(PopularMoviesLoading());
      when(topRatedMoviesCubit.state).thenReturn(TopRatedMoviesLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));
      expect(progressFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(nowPlayingMoviesCubit.state)
          .thenReturn(NowPlayingMoviesLoaded(testMovieList));
      when(popularMoviesCubit.state)
          .thenReturn(PopularMoviesLoaded(testMovieList));
      when(topRatedMoviesCubit.state)
          .thenReturn(TopRatedMoviesLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));
      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(nowPlayingMoviesCubit.state)
          .thenReturn(const NowPlayingMoviesError('error'));
      when(popularMoviesCubit.state)
          .thenReturn(const PopularMoviesError('error'));
      when(topRatedMoviesCubit.state)
          .thenReturn(const TopRatedMoviesError('error'));

      final errorFinder = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));
      expect(errorFinder, findsNWidgets(3));
    },
  );
}
