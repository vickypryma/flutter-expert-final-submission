import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchPage {
  final WidgetTester tester;

  SearchPage(this.tester);

  Future<void> search(String query) async {
    final textFieldFinder = find.byKey(const Key('search_text_field'));

    await tester.ensureVisible(textFieldFinder);
    await tester.enterText(textFieldFinder, query);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    tester.printToConsole('search "$query"');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 4));
  }

  Future<void> clickMovieRadio() async {
    final movieRadio = find.byKey(const Key('movie_radio'));

    await tester.ensureVisible(movieRadio);
    await tester.tap(movieRadio);
    tester.printToConsole('change search type to Movie');

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  Future<void> clickTvRadio() async {
    final tvRadio = find.byKey(const Key('tv_radio'));

    await tester.ensureVisible(tvRadio);
    await tester.tap(tvRadio);
    tester.printToConsole('change search type to TV Series');

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
