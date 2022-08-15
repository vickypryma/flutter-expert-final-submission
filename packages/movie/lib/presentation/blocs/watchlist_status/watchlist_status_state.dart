part of 'watchlist_status_cubit.dart';

class WatchlistStatusState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const WatchlistStatusState(
      {this.isAddedToWatchlist = false, this.message = ''});

  @override
  List<Object?> get props => [isAddedToWatchlist, message];
}
