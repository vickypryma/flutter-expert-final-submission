import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

import '../../../domain/entities/tv.dart';

part 'watchlist_tv_state.dart';

class WatchlistTvCubit extends Cubit<WatchlistTvState> {
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvCubit(this.getWatchlistTv) : super(WatchlistTvEmpty());

  Future<void> fetchWatchlistTv() async {
    emit(WatchlistTvLoading());

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) => emit(WatchlistTvError(failure.message)),
      (data) => emit(WatchlistTvLoaded(data)),
    );
  }
}
