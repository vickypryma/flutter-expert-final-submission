import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/watchlist_movies/watchlist_movies_cubit.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistMoviesCubit])
void main() {
  late MockWatchlistMoviesCubit cubit;

  setUp(() {
    cubit = MockWatchlistMoviesCubit();
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesCubit>.value(
      value: cubit,
      child: MaterialApp(
        home: Material(
          child: body,
        ),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(cubit.state).thenReturn(WatchlistMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(cubit.state).thenReturn(WatchlistMoviesLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(cubit.state).thenReturn(const WatchlistMoviesError('error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
