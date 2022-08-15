part of 'tv_watchlist_status_cubit.dart';

class TvWatchlistStatusState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const TvWatchlistStatusState({
    this.isAddedToWatchlist = false,
    this.message = '',
  });

  @override
  List<Object?> get props => [isAddedToWatchlist, message];
}
