import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';

import '../../../domain/usecases/get_airing_today_tv.dart';

part 'airing_today_tv_state.dart';

class AiringTodayTvCubit extends Cubit<AiringTodayTvState> {
  final GetAiringTodayTv getAiringTodayTv;

  AiringTodayTvCubit(this.getAiringTodayTv) : super(AiringTodayTvEmpty());

  Future<void> fetchAiringTodayTv() async {
    emit(AiringTodayTvLoading());

    final result = await getAiringTodayTv.execute();
    result.fold(
      (failure) => emit(AiringTodayTvError(failure.message)),
      (data) => emit(AiringTodayTvLoaded(data)),
    );
  }
}
