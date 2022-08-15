part of 'movie_detail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  final String message;

  const MovieDetailState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;
  final List<Movie> recommendationMovies;

  const MovieDetailLoaded(this.movie, this.recommendationMovies);

  @override
  List<Object?> get props => [movie, recommendationMovies];
}

class MovieDetailError extends MovieDetailState {
  const MovieDetailError(String message) : super(message: message);

  @override
  List<Object?> get props => [message];
}
