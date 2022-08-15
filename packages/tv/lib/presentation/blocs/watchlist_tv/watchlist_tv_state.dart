part of 'watchlist_tv_cubit.dart';

abstract class WatchlistTvState extends Equatable {
  final String message;

  const WatchlistTvState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvLoaded extends WatchlistTvState {
  final List<Tv> result;

  const WatchlistTvLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistTvError extends WatchlistTvState {
  const WatchlistTvError(String message) : super(message: message);
}
