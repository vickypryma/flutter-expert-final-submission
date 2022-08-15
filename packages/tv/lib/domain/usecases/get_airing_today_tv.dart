import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

import '../entities/tv.dart';

class GetAiringTodayTv {
  final TvRepository repository;

  GetAiringTodayTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getAiringTodayTv();
  }
}
