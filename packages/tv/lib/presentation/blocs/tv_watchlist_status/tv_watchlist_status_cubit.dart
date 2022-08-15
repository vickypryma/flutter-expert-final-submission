import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv_detail.dart';
import '../../../domain/usecases/get_tv_watchlist_status.dart';
import '../../../domain/usecases/remove_tv_watchlist.dart';
import '../../../domain/usecases/save_tv_watchlist.dart';

part 'tv_watchlist_status_state.dart';

class TvWatchlistStatusCubit extends Cubit<TvWatchlistStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvWatchlistStatus getTvWatchListStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  TvWatchlistStatusCubit({
    required this.getTvWatchListStatus,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
  }) : super(const TvWatchlistStatusState());

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvWatchListStatus.execute(id);
    emit(TvWatchlistStatusState(isAddedToWatchlist: result));
  }

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveTvWatchlist.execute(tv);
    result.fold(
      (failure) => emit(TvWatchlistStatusState(message: failure.message)),
      (message) => emit(TvWatchlistStatusState(
        isAddedToWatchlist: true,
        message: message,
      )),
    );
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeTvWatchlist.execute(tv);
    result.fold(
      (failure) => emit(TvWatchlistStatusState(message: failure.message)),
      (message) => emit(TvWatchlistStatusState(
        isAddedToWatchlist: false,
        message: message,
      )),
    );
  }
}
