import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/episode.dart';

import '../entities/tv.dart';
import '../entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getAiringTodayTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tv);
  Future<bool> isAddedToTvWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
  Future<Either<Failure, List<Episode>>> getEpisodes(int id, int season);
}
