import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesCubit(this.getTopRatedMovies) : super(TopRatedMoviesEmpty());

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(TopRatedMoviesError(failure.message)),
      (data) => emit(TopRatedMoviesLoaded(data)),
    );
  }
}
