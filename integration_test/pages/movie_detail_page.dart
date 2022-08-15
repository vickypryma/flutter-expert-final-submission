import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MovieDetailPage {
  final WidgetTester tester;

  MovieDetailPage(this.tester);

  Future<void> scrollPage({scrollUp = false}) async {
    final contentFinder = find.byKey(const Key('movie_detail_content'));

    await tester.ensureVisible(contentFinder);
    if (scrollUp) {
      tester.printToConsole('scrolling up page');
      await tester.fling(contentFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      tester.printToConsole('scrolling down page');
      await tester.fling(contentFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
    sleep(const Duration(seconds: 2));
  }

  Future<void> clickWatchlistButton() async {
    final buttonFinder = find.byKey(const Key('watchlist_button'));

    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    tester.printToConsole('add to watchlist');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> goBack() async {
    final buttonFinder = find.byKey(const Key('back_button'));

    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    tester.printToConsole('navigate back');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
