part of 'top_rated_movies_cubit.dart';

abstract class TopRatedMoviesState extends Equatable {
  final String message;

  const TopRatedMoviesState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class TopRatedMoviesEmpty extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesLoaded extends TopRatedMoviesState {
  final List<Movie> result;

  const TopRatedMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  const TopRatedMoviesError(String message) : super(message: message);

  @override
  List<Object> get props => [message];
}
