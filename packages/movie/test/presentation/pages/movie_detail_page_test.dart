import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie/presentation/blocs/watchlist_status/watchlist_status_cubit.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailCubit, WatchlistStatusCubit])
void main() {
  late MockMovieDetailCubit detailCubit;
  late MockWatchlistStatusCubit statusCubit;

  setUp(() {
    detailCubit = MockMovieDetailCubit();
    statusCubit = MockWatchlistStatusCubit();
    when(detailCubit.stream).thenAnswer((_) => const Stream.empty());
    when(statusCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailCubit>.value(value: detailCubit),
        BlocProvider<WatchlistStatusCubit>.value(value: statusCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(detailCubit.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail, testMovieList));
    when(statusCubit.state).thenReturn(const WatchlistStatusState());

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(detailCubit.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail, testMovieList));
    when(statusCubit.state)
        .thenReturn(const WatchlistStatusState(isAddedToWatchlist: true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(detailCubit.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail, testMovieList));
    when(statusCubit.state)
        .thenReturn(const WatchlistStatusState(message: 'Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(detailCubit.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail, testMovieList));
    when(statusCubit.state)
        .thenReturn(const WatchlistStatusState(message: 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
