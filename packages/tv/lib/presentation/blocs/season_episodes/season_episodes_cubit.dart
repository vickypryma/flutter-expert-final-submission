import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_episodes.dart';

import '../../../domain/entities/episode.dart';

part 'season_episodes_state.dart';

class SeasonEpisodesCubit extends Cubit<SeasonEpisodesState> {
  final GetEpisodes getEpisodes;

  SeasonEpisodesCubit(this.getEpisodes) : super(SeasonEpisodesEmpty());

  Future<void> fetchEpisodes(int id, int season) async {
    emit(SeasonEpisodesLoading());

    final result = await getEpisodes.execute(id, season);
    result.fold(
      (failure) => emit(SeasonEpisodesError(failure.message)),
      (data) => emit(SeasonEpisodesLoaded(data)),
    );
  }
}
