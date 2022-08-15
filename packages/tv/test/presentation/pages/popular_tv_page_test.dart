import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([PopularTvCubit])
void main() {
  late MockPopularTvCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularTvCubit();
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(mockCubit.state).thenReturn(PopularTvLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(mockCubit.state).thenReturn(const PopularTvLoaded(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));
      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(mockCubit.state).thenReturn(const PopularTvError('error'));

      final errorFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));
      expect(errorFinder, findsOneWidget);
    },
  );
}
