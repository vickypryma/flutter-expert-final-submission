import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WatchlistPage {
  final WidgetTester tester;

  WatchlistPage(this.tester);

  Future<void> clickMoviesWatchlistTab() async {
    final tabFinder = find.byKey(const Key('movies_tab'));

    await tester.ensureVisible(tabFinder);
    await tester.tap(tabFinder);
    tester.printToConsole('open movies watchlist tab');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> clickTvWatchlistTab() async {
    final tabFinder = find.byKey(const Key('tv_tab'));

    await tester.ensureVisible(tabFinder);
    await tester.tap(tabFinder);
    tester.printToConsole('open tv series watchlist tab');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
