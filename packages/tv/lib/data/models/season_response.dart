import 'package:equatable/equatable.dart';
import 'package:tv/data/models/episode_model.dart';

class SeasonResponse extends Equatable {
  final List<EpisodeModel> episodeList;

  const SeasonResponse(this.episodeList);

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => SeasonResponse(
        List<EpisodeModel>.from(
            (json['episodes'] as List).map((x) => EpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'episodes': List<dynamic>.from(episodeList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [episodeList];
}
