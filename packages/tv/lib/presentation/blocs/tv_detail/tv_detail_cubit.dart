import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

import '../../../domain/entities/tv.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailCubit({
    required this.getTvDetail,
    required this.getTvRecommendations,
  }) : super(TvDetailEmpty());

  Future<void> fetchTvDetail(int id) async {
    emit(TvDetailLoading());

    final result = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    result.fold(
      (failure) => emit(TvDetailError(failure.message)),
      (data) {
        recommendationResult.fold(
          (failure) => emit(TvDetailError(failure.message)),
          (movies) => emit(TvDetailLoaded(data, movies)),
        );
      },
    );
  }
}
