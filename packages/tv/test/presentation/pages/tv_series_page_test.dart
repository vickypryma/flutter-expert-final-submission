import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/airing_today_tv/airing_today_tv_cubit.dart';
import 'package:tv/presentation/blocs/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/blocs/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:tv/presentation/pages/tv_series_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_tv_page_test.mocks.dart';
import 'popular_tv_page_test.mocks.dart';
import 'top_rated_tv_page_test.mocks.dart';

void main() {
  late MockAiringTodayTvCubit airingTodayTvCubit;
  late MockPopularTvCubit popularTvCubit;
  late MockTopRatedTvCubit topRatedTvCubit;

  setUp(() {
    airingTodayTvCubit = MockAiringTodayTvCubit();
    popularTvCubit = MockPopularTvCubit();
    topRatedTvCubit = MockTopRatedTvCubit();
    when(airingTodayTvCubit.stream).thenAnswer((_) => const Stream.empty());
    when(popularTvCubit.stream).thenAnswer((_) => const Stream.empty());
    when(topRatedTvCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AiringTodayTvCubit>.value(value: airingTodayTvCubit),
        BlocProvider<PopularTvCubit>.value(value: popularTvCubit),
        BlocProvider<TopRatedTvCubit>.value(value: topRatedTvCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress bar when state is Loading',
    (tester) async {
      when(airingTodayTvCubit.state).thenReturn(AiringTodayTvLoading());
      when(popularTvCubit.state).thenReturn(PopularTvLoading());
      when(topRatedTvCubit.state).thenReturn(TopRatedTvLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));
      expect(progressFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'should display listview when state is Loaded',
    (tester) async {
      when(airingTodayTvCubit.state)
          .thenReturn(const AiringTodayTvLoaded(testTvList));
      when(popularTvCubit.state).thenReturn(const PopularTvLoaded(testTvList));
      when(topRatedTvCubit.state)
          .thenReturn(const TopRatedTvLoaded(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));
      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'should display error message when state is Error',
    (tester) async {
      when(airingTodayTvCubit.state)
          .thenReturn(const AiringTodayTvError('error'));
      when(popularTvCubit.state).thenReturn(const PopularTvError('error'));
      when(topRatedTvCubit.state).thenReturn(const TopRatedTvError('error'));

      final errorFinder = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));
      expect(errorFinder, findsNWidgets(3));
    },
  );
}
