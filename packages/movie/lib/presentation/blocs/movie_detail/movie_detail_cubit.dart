import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

import '../../../domain/entities/movie.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super(MovieDetailEmpty());

  Future<void> fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());

    final result = await getMovieDetail.execute(id);
    final recommendationsResult = await getMovieRecommendations.execute(id);

    result.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (data) {
        recommendationsResult.fold(
          (failure) => emit(MovieDetailError(failure.message)),
          (movies) => emit(MovieDetailLoaded(data, movies)),
        );
      },
    );
  }
}
