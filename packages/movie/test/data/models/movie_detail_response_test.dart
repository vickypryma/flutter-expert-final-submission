import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';

void main() {
  const tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [GenreModel(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    imdbId: 'abc123',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovieDetailMap = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'budget': 1,
    'genres': [
      {'id': 1, 'name': 'name'}
    ],
    'homepage': 'homepage',
    'id': 1,
    'imdb_id': 'abc123',
    'original_language': 'originalLanguage',
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'release_date': 'releaseDate',
    'revenue': 1,
    'runtime': 1,
    'status': 'status',
    'tagline': 'tagline',
    'title': 'title',
    'video': false,
    'vote_average': 1.0,
    'vote_count': 1,
  };

  test('should return a JSON map containing proper data', () {
    final result = tMovieDetailResponse.toJson();
    expect(result, tMovieDetailMap);
  });
}
