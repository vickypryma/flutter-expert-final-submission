import 'package:movie/domain/entities/movie.dart';
import 'package:tv/domain/entities/tv.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: const [1],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);

const testTv = Tv(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
);
