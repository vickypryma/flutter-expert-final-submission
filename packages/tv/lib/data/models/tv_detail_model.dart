import 'package:equatable/equatable.dart';
import 'package:tv/data/models/season_model.dart';

import '../../domain/entities/tv_detail.dart';
import 'genre_model.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
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
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final List<SeasonModel> seasons;
  final double voteAverage;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasons: List<SeasonModel>.from((json["seasons"] as List)
            .map((x) => SeasonModel.fromJson(x))
            .where((x) => x.posterPath != null)),
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "vote_average": voteAverage,
      };

  TvDetail toEntity() {
    return TvDetail(
      episodeRunTime: episodeRunTime,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasons: seasons.map((season) => season.toEntity()).toList(),
      voteAverage: voteAverage,
    );
  }

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
