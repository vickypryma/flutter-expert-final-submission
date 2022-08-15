import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season.dart';

import 'genre.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.episodeRunTime,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
  });

  final List<int> episodeRunTime;
  final List<Genre>? genres;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final List<Season> seasons;
  final double? voteAverage;

  @override
  List<Object?> get props => [
        episodeRunTime,
        genres,
        id,
        name,
        overview,
        posterPath,
        seasons,
        voteAverage,
      ];
}
