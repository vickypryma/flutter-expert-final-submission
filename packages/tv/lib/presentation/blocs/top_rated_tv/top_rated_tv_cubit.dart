import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_top_rated_tv_series.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvCubit(this.getTopRatedTv) : super(TopRatedTvEmpty());

  Future<void> fetchTopRatedTv() async {
    emit(TopRatedTvLoading());

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) => emit(TopRatedTvError(failure.message)),
      (data) => emit(TopRatedTvLoaded(data)),
    );
  }
}
