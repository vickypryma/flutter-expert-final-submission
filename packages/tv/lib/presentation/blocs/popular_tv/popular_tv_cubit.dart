import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_popular_tv.dart';

part 'popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvCubit(this.getPopularTv) : super(PopularTvEmpty());

  Future<void> fetchPopularTv() async {
    emit(PopularTvLoading());

    final result = await getPopularTv.execute();
    result.fold(
      (failure) => emit(PopularTvError(failure.message)),
      (data) => emit(PopularTvLoaded(data)),
    );
  }
}
