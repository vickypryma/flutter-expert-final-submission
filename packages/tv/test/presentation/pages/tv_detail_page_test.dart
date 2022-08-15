import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/blocs/tv_watchlist_status/tv_watchlist_status_cubit.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailCubit, TvWatchlistStatusCubit])
void main() {
  late MockTvDetailCubit detailCubit;
  late MockTvWatchlistStatusCubit statusCubit;

  setUp(() {
    detailCubit = MockTvDetailCubit();
    statusCubit = MockTvWatchlistStatusCubit();
    when(detailCubit.stream).thenAnswer((_) => const Stream.empty());
    when(statusCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailCubit>.value(value: detailCubit),
        BlocProvider<TvWatchlistStatusCubit>.value(value: statusCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(detailCubit.state).thenReturn(TvDetailLoading());
      when(statusCubit.state).thenReturn(const TvWatchlistStatusState());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(detailCubit.state).thenReturn(const TvDetailError('error'));
      when(statusCubit.state).thenReturn(const TvWatchlistStatusState());

      final errorFinder = find.text('error');

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
      expect(errorFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(detailCubit.state)
        .thenReturn(const TvDetailLoaded(testTvDetail, testTvList));
    when(statusCubit.state).thenReturn(const TvWatchlistStatusState());

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(detailCubit.state)
        .thenReturn(const TvDetailLoaded(testTvDetail, testTvList));
    when(statusCubit.state)
        .thenReturn(const TvWatchlistStatusState(isAddedToWatchlist: true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(detailCubit.state)
        .thenReturn(const TvDetailLoaded(testTvDetail, testTvList));
    when(statusCubit.state).thenReturn(
        const TvWatchlistStatusState(message: 'Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

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
        .thenReturn(const TvDetailLoaded(testTvDetail, testTvList));
    when(statusCubit.state)
        .thenReturn(const TvWatchlistStatusState(message: 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
