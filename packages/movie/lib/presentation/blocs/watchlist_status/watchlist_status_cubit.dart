import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

import '../../../domain/entities/movie_detail.dart';

part 'watchlist_status_state.dart';

class WatchlistStatusCubit extends Cubit<WatchlistStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchlistStatusCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const WatchlistStatusState());

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(WatchlistStatusState(isAddedToWatchlist: result));
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);
    result.fold(
      (failure) => emit(WatchlistStatusState(message: failure.message)),
      (message) => emit(WatchlistStatusState(
        isAddedToWatchlist: true,
        message: message,
      )),
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);
    result.fold(
      (failure) => emit(WatchlistStatusState(message: failure.message)),
      (message) => emit(WatchlistStatusState(
        isAddedToWatchlist: false,
        message: message,
      )),
    );
  }
}
