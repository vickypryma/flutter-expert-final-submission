import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

import '../../../domain/entities/movie.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesCubit(this.getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty());

  Future<void> fetchNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(NowPlayingMoviesError(failure.message)),
      (data) => emit(NowPlayingMoviesLoaded(data)),
    );
  }
}
