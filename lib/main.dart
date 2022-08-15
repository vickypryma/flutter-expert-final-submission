import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/utils/custom_client.dart';
import 'package:core/widgets/custom_drawer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie/presentation/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/presentation/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/presentation/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/presentation/blocs/watchlist_movies/watchlist_movies_cubit.dart';
import 'package:movie/presentation/blocs/watchlist_status/watchlist_status_cubit.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:search/search.dart';
import 'package:tv/presentation/blocs/airing_today_tv/airing_today_tv_cubit.dart';
import 'package:tv/presentation/blocs/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/blocs/season_episodes/season_episodes_cubit.dart';
import 'package:tv/presentation/blocs/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:tv/presentation/blocs/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/blocs/tv_watchlist_status/tv_watchlist_status_cubit.dart';
import 'package:tv/presentation/blocs/watchlist_tv/watchlist_tv_cubit.dart';
import 'package:tv/presentation/pages/airing_today_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/season_episodes_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv_series_page.dart';
import 'package:watchlist/watchlist.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomClient.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistStatusCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AiringTodayTvCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistStatusCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeasonEpisodesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
          child: CustomDrawer(
            pages: {
              HomeMoviePage.routeName: (_) => const HomeMoviePage(),
              TvSeriesPage.routeName: (_) => const TvSeriesPage(),
              WatchlistPage.routeName: (_) => const WatchlistPage(),
            },
          ),
        ),
        navigatorObservers: [routeObserver, observer],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case AiringTodayTvPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const AiringTodayTvPage());
            case PopularTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularTvPage());
            case TopRatedTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TopRatedTvPage());
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SeasonEpisodesPage.routeName:
              final args = settings.arguments as Map<String, int>;
              return CupertinoPageRoute(
                builder: (_) => SeasonEpisodesPage(
                  id: args['id']!,
                  season: args['season']!,
                ),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
