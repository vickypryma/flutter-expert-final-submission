import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/watchlist_tv/watchlist_tv_cubit.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_page_test.mocks.dart';

@GenerateMocks([WatchlistTvCubit])
void main() {
  late MockWatchlistTvCubit mockCubit;

  setUp(() {
    mockCubit = MockWatchlistTvCubit();
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: Material(
          child: body,
        ),
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(mockCubit.state).thenReturn(WatchlistTvLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(mockCubit.state).thenReturn(const WatchlistTvLoaded(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));
      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(mockCubit.state).thenReturn(const WatchlistTvError('error'));

      final errorFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));
      expect(errorFinder, findsOneWidget);
    },
  );
}
