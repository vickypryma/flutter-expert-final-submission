import 'package:core/utils/custom_client.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:movie/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie/presentation/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/presentation/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/presentation/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/presentation/blocs/watchlist_movies/watchlist_movies_cubit.dart';
import 'package:movie/presentation/blocs/watchlist_status/watchlist_status_cubit.dart';
import 'package:search/blocs/search_cubit.dart';
import 'package:tv/data/datasources/db/tv_database_helper.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/get_airing_today_tv.dart';
import 'package:tv/domain/usecases/get_episodes.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/blocs/airing_today_tv/airing_today_tv_cubit.dart';
import 'package:tv/presentation/blocs/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/blocs/season_episodes/season_episodes_cubit.dart';
import 'package:tv/presentation/blocs/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:tv/presentation/blocs/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/blocs/tv_watchlist_status/tv_watchlist_status_cubit.dart';
import 'package:tv/presentation/blocs/watchlist_tv/watchlist_tv_cubit.dart';

final locator = GetIt.instance;

void init() {
  // blocs
  locator.registerFactory(
    () => NowPlayingMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistStatusCubit(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => AiringTodayTvCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailCubit(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistStatusCubit(
      getTvWatchListStatus: locator(),
      saveTvWatchlist: locator(),
      removeTvWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SeasonEpisodesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchCubit(
      searchMovies: locator(),
      searchTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetAiringTodayTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetEpisodes(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => IOClient(CustomClient.client));
}
