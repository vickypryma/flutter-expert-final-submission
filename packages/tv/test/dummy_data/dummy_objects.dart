import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

const testTv = Tv(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
);

const testTvList = [testTv];

const testTvModel = TvModel(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
);

const testTvModelList = [testTvModel];

const testTvMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'poster_path': 'posterPath',
};

const testTvDetail = TvDetail(
  episodeRunTime: [30],
  genres: [Genre(id: 1, name: 'name')],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [testSeason],
  voteAverage: 1.0,
);

const testTvDetailResponse = TvDetailResponse(
  episodeRunTime: [30],
  genres: [GenreModel(id: 1, name: 'name')],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [testSeasonModel],
  voteAverage: 1.0,
);

const testTvDetailMap = {
  'episode_run_time': [30],
  'genres': [
    {'id': 1, 'name': 'name'}
  ],
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'poster_path': 'posterPath',
  'seasons': [testSeasonMap],
  'vote_average': 1.0,
};

const testSeason = Season(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const testSeasonModel = SeasonModel(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const testSeasonMap = {
  'id': 1,
  'name': 'name',
  'poster_path': 'posterPath',
  'season_number': 1,
};

const testEpisode = Episode(
  episodeNumber: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  stillPath: 'stillPath',
);

const testEpisodeList = [testEpisode];

const testEpisodeModel = EpisodeModel(
  episodeNumber: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  stillPath: 'stillPath',
);

const testEpisodeModelList = [testEpisodeModel];

const testEpisodeMap = {
  'episode_number': 1,
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'still_path': 'stillPath',
};
