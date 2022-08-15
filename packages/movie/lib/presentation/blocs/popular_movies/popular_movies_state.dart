part of 'popular_movies_cubit.dart';

abstract class PopularMoviesState extends Equatable {
  final String message;

  const PopularMoviesState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class PopularMoviesEmpty extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie> result;

  const PopularMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError(String message) : super(message: message);

  @override
  List<Object> get props => [message];
}
