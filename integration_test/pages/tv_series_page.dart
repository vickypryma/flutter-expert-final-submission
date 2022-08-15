import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TvSeriesPage {
  final WidgetTester tester;

  TvSeriesPage(this.tester);

  Future<void> openAiringTv() async {
    final airingButtonFinder = find.byKey(const Key('see_airing_tv'));

    await tester.ensureVisible(airingButtonFinder);
    await tester.tap(airingButtonFinder);
    tester.printToConsole('open airing today tv series page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> scrollAiringTv({scrollUp = false}) async {
    final listViewFinder = find.byKey(const Key('airing_tv_listview'));

    await tester.ensureVisible(listViewFinder);
    if (scrollUp) {
      tester.printToConsole('scrolling up page');
      await tester.fling(listViewFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      tester.printToConsole('scrolling down page');
      await tester.fling(listViewFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
    sleep(const Duration(seconds: 2));
  }

  Future<void> openPopularTv() async {
    final popularButtonFinder = find.byKey(const Key('see_popular_tv'));

    await tester.ensureVisible(popularButtonFinder);
    await tester.tap(popularButtonFinder);
    tester.printToConsole('open popular tv series page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> scrollPopularTv({scrollUp = false}) async {
    final listViewFinder = find.byKey(const Key('popular_tv_listview'));

    await tester.ensureVisible(listViewFinder);
    if (scrollUp) {
      tester.printToConsole('scrolling up page');
      await tester.fling(listViewFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      tester.printToConsole('scrolling down page');
      await tester.fling(listViewFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
    sleep(const Duration(seconds: 2));
  }

  Future<void> openTopRatedTv() async {
    final topRatedButtonFinder = find.byKey(const Key('see_top_rated_tv'));

    await tester.ensureVisible(topRatedButtonFinder);
    await tester.tap(topRatedButtonFinder);
    tester.printToConsole('open top rated tv series page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> scrollTopRatedTv({scrollUp = false}) async {
    final listViewFinder = find.byKey(const Key('top_rated_tv_listview'));

    await tester.ensureVisible(listViewFinder);
    if (scrollUp) {
      tester.printToConsole('scrolling up page');
      await tester.fling(listViewFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      tester.printToConsole('scrolling down page');
      await tester.fling(listViewFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
    sleep(const Duration(seconds: 2));
  }

  Future<void> openTvDetail() async {
    final finder = find.byKey(const Key('tv_list'));

    await tester.ensureVisible(finder.first);
    await tester.tap(finder.first);
    tester.printToConsole('open tv series detail page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> goBack() async {
    tester.printToConsole('navigate back');
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
