import 'package:flutter_expert_final_submission/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'pages/home_page.dart';
import 'pages/movie_detail_page.dart';
import 'pages/search_page.dart';
import 'pages/tv_series_detail_page.dart';
import 'pages/tv_series_page.dart';
import 'pages/watchlist_page.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  HomePage homePage;
  TvSeriesPage tvSeriesPage;
  MovieDetailPage movieDetailPage;
  TvSeriesDetailPage tvSeriesDetailPage;
  WatchlistPage watchlistPage;
  SearchPage searchPage;

  group('end-to-end-test', () {
    testWidgets('whole app', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      homePage = HomePage(tester);
      tvSeriesPage = TvSeriesPage(tester);
      movieDetailPage = MovieDetailPage(tester);
      tvSeriesDetailPage = TvSeriesDetailPage(tester);
      watchlistPage = WatchlistPage(tester);
      searchPage = SearchPage(tester);

      tester.printToConsole('1. See popular movies page');
      await homePage.openPopularMovies();
      await homePage.scrollPopularMovies();
      await homePage.scrollPopularMovies(scrollUp: true);
      await homePage.goBack();

      tester.printToConsole('2. See top rated movies page');
      await homePage.openTopRatedMovies();
      await homePage.scrollTopRatedMovies();
      await homePage.scrollTopRatedMovies(scrollUp: true);
      await homePage.goBack();

      tester.printToConsole('3. Open tv series page');
      await homePage.openDrawer();
      await homePage.openTvSeriesPage();

      tester.printToConsole('4. See airing today tv series page');
      await tvSeriesPage.openAiringTv();
      await tvSeriesPage.scrollAiringTv();
      await tvSeriesPage.scrollAiringTv(scrollUp: true);
      await tvSeriesPage.goBack();

      tester.printToConsole('5. See popular tv series page');
      await tvSeriesPage.openPopularTv();
      await tvSeriesPage.scrollPopularTv();
      await tvSeriesPage.scrollPopularTv(scrollUp: true);
      await tvSeriesPage.goBack();

      tester.printToConsole('6. See top rated tv series page');
      await tvSeriesPage.openTopRatedTv();
      await tvSeriesPage.scrollTopRatedTv();
      await tvSeriesPage.scrollTopRatedTv(scrollUp: true);
      await tvSeriesPage.goBack();

      tester.printToConsole('7. Open movie detail page');
      await homePage.openDrawer();
      await homePage.openMoviesPage();
      await homePage.openMovieDetail();
      await movieDetailPage.scrollPage();
      await movieDetailPage.clickWatchlistButton();
      await movieDetailPage.scrollPage(scrollUp: true);
      await movieDetailPage.goBack();

      tester.printToConsole('8. Open tv series detail page');
      await homePage.openDrawer();
      await homePage.openTvSeriesPage();
      await tvSeriesPage.openTvDetail();
      await tvSeriesDetailPage.scrollPage();
      await tvSeriesDetailPage.clickWatchlistButton();
      await tvSeriesDetailPage.scrollPage(scrollUp: true);
      await tvSeriesDetailPage.goBack();

      tester.printToConsole('9. Open watchlist page');
      await homePage.openDrawer();
      await homePage.openWatchlistPage();
      await watchlistPage.clickTvWatchlistTab();
      await watchlistPage.clickMoviesWatchlistTab();

      tester.printToConsole('10. Open search page');
      await homePage.openSearch();
      await searchPage.clickTvRadio();
      await searchPage.search('spiderman');
      await searchPage.clickMovieRadio();
      await searchPage.goBack();

      tester.printToConsole('11. Open about page');
      await homePage.openDrawer();
      await homePage.openAboutPage();

      tester.printToConsole('Test finished...');
    });
  });
}
