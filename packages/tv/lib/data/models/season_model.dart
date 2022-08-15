import 'package:equatable/equatable.dart';

import '../../domain/entities/season.dart';

class SeasonModel extends Equatable {
  const SeasonModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
  });

  final int id;
  final String name;
  final String? posterPath;
  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      id: id,
      name: name,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        seasonNumber,
      ];
}
