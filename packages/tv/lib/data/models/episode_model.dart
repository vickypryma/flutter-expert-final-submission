import 'package:equatable/equatable.dart';

import '../../domain/entities/episode.dart';

class EpisodeModel extends Equatable {
  const EpisodeModel({
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
  });

  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String? stillPath;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toJson() => {
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "still_path": stillPath,
      };

  Episode toEntity() => Episode(
        episodeNumber: episodeNumber,
        id: id,
        name: name,
        overview: overview,
        stillPath: stillPath,
      );

  @override
  List<Object?> get props => [
        episodeNumber,
        id,
        name,
        overview,
        stillPath,
      ];
}
