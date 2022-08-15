import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'dummy_objects.dart';
import 'search_page_test.mocks.dart';

@GenerateMocks([SearchCubit])
void main() {
  late MockSearchCubit mockSearchCubit;

  setUp(() {
    mockSearchCubit = MockSearchCubit();
    when(mockSearchCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchCubit>.value(
      value: mockSearchCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(mockSearchCubit.state).thenReturn(const SearchLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(mockSearchCubit.state).thenReturn(SearchLoaded([testMovie], 'test'));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));
      expect(listViewFinder, findsOneWidget);
    },
  );
}
