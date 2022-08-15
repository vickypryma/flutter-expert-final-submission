import 'package:equatable/equatable.dart';

class Season extends Equatable {
  const Season({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
  });

  final int id;
  final String name;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        seasonNumber,
      ];
}
