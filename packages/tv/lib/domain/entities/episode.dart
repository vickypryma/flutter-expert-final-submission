import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  const Episode({
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

  @override
  List<Object?> get props => [
        episodeNumber,
        id,
        name,
        overview,
        stillPath,
      ];
}
