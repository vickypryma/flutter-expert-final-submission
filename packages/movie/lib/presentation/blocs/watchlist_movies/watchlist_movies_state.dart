part of 'watchlist_movies_cubit.dart';

abstract class WatchlistMoviesState extends Equatable {
  final String message;

  const WatchlistMoviesState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesLoaded extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  const WatchlistMoviesError(String message) : super(message: message);

  @override
  List<Object> get props => [message];
}
