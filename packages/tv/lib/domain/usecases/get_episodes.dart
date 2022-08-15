import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetEpisodes {
  final TvRepository repository;

  GetEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int season) {
    return repository.getEpisodes(id, season);
  }
}
