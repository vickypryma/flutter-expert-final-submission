import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTvCubit])
void main() {
  late MockTopRatedTvCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRatedTvCubit();
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(mockCubit.state).thenReturn(TopRatedTvLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(mockCubit.state).thenReturn(const TopRatedTvLoaded(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));
      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(mockCubit.state).thenReturn(const TopRatedTvError('error'));

      final errorFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));
      expect(errorFinder, findsOneWidget);
    },
  );
}
