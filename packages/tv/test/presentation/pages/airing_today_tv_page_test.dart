import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/airing_today_tv/airing_today_tv_cubit.dart';
import 'package:tv/presentation/pages/airing_today_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_tv_page_test.mocks.dart';

@GenerateMocks([AiringTodayTvCubit])
void main() {
  late MockAiringTodayTvCubit mockCubit;

  setUp(() {
    mockCubit = MockAiringTodayTvCubit();
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<AiringTodayTvCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(mockCubit.state).thenReturn(AiringTodayTvLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const AiringTodayTvPage()));
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(mockCubit.state).thenReturn(const AiringTodayTvLoaded(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const AiringTodayTvPage()));
      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(mockCubit.state).thenReturn(const AiringTodayTvError('error'));

      final errorFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const AiringTodayTvPage()));
      expect(errorFinder, findsOneWidget);
    },
  );
}
