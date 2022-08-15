part of 'season_episodes_cubit.dart';

abstract class SeasonEpisodesState extends Equatable {
  final String message;

  const SeasonEpisodesState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class SeasonEpisodesEmpty extends SeasonEpisodesState {}

class SeasonEpisodesLoading extends SeasonEpisodesState {}

class SeasonEpisodesLoaded extends SeasonEpisodesState {
  final List<Episode> result;

  const SeasonEpisodesLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class SeasonEpisodesError extends SeasonEpisodesState {
  const SeasonEpisodesError(String message) : super(message: message);
}
