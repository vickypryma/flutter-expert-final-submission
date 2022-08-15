import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

import '../../../domain/entities/movie.dart';

part 'watchlist_movies_state.dart';

class WatchlistMoviesCubit extends Cubit<WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesCubit(this.getWatchlistMovies) : super(WatchlistMoviesEmpty());

  Future<void> fetchWatchlistMovies() async {
    emit(WatchlistMoviesLoading());

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) => emit(WatchlistMoviesError(failure.message)),
      (data) => emit(WatchlistMoviesLoaded(data)),
    );
  }
}
