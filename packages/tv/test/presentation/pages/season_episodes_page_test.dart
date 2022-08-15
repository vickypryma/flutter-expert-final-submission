import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/season_episodes/season_episodes_cubit.dart';
import 'package:tv/presentation/pages/season_episodes_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'season_episodes_page_test.mocks.dart';

@GenerateMocks([SeasonEpisodesCubit])
void main() {
  late MockSeasonEpisodesCubit mockCubit;

  setUp(() {
    mockCubit = MockSeasonEpisodesCubit();
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeasonEpisodesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(mockCubit.state).thenReturn(SeasonEpisodesLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const SeasonEpisodesPage(
        id: 1,
        season: 1,
      )));
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(mockCubit.state)
          .thenReturn(const SeasonEpisodesLoaded(testEpisodeList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const SeasonEpisodesPage(
        id: 1,
        season: 1,
      )));
      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(mockCubit.state).thenReturn(const SeasonEpisodesError('error'));

      final errorFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const SeasonEpisodesPage(
        id: 1,
        season: 1,
      )));
      expect(errorFinder, findsOneWidget);
    },
  );
}
