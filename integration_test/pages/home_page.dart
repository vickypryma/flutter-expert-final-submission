import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomePage {
  final WidgetTester tester;

  HomePage(this.tester);

  Future<void> openDrawer() async {
    final drawerButtonFinder = find.byKey(const Key('drawer_button'));

    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);
    tester.printToConsole('open drawer');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> openMoviesPage() async {
    final movieListTile = find.byKey(const Key('movie_list_tile'));

    await tester.ensureVisible(movieListTile);
    await tester.tap(movieListTile);
    tester.printToConsole('open movies page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> openTvSeriesPage() async {
    final tvListTile = find.byKey(const Key('tv_list_tile'));

    await tester.ensureVisible(tvListTile);
    await tester.tap(tvListTile);
    tester.printToConsole('open tv series page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> openWatchlistPage() async {
    final watchlistListTile = find.byKey(const Key('watchlist_list_tile'));

    await tester.ensureVisible(watchlistListTile);
    await tester.tap(watchlistListTile);
    tester.printToConsole('open watchlist page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> openAboutPage() async {
    final aboutListTile = find.byKey(const Key('about_list_tile'));

    await tester.ensureVisible(aboutListTile);
    await tester.tap(aboutListTile);
    tester.printToConsole('open about page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> openSearch() async {
    final searchButtonFinder = find.byKey(const Key('search_button'));

    await tester.ensureVisible(searchButtonFinder);
    await tester.tap(searchButtonFinder);
    tester.printToConsole('open search page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> openPopularMovies() async {
    final popularButtonFinder = find.byKey(const Key('see_popular_movies'));

    await tester.ensureVisible(popularButtonFinder);
    await tester.tap(popularButtonFinder);
    tester.printToConsole('open popular movies page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> scrollPopularMovies({scrollUp = false}) async {
    final listViewFinder = find.byKey(const Key('popular_movies_listview'));

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

  Future<void> openTopRatedMovies() async {
    final topRatedButtonFinder = find.byKey(const Key('see_top_rated_movies'));

    await tester.ensureVisible(topRatedButtonFinder);
    await tester.tap(topRatedButtonFinder);
    tester.printToConsole('open top rated movies page');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> scrollTopRatedMovies({scrollUp = false}) async {
    final listViewFinder = find.byKey(const Key('top_rated_movies_listview'));

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

  Future<void> openMovieDetail() async {
    final finder = find.byKey(const Key('movie_list'));

    await tester.ensureVisible(finder.first);
    await tester.tap(finder.first);
    tester.printToConsole('open movie detail page');

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
