part of 'airing_today_tv_cubit.dart';

abstract class AiringTodayTvState extends Equatable {
  final String message;

  const AiringTodayTvState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class AiringTodayTvEmpty extends AiringTodayTvState {}

class AiringTodayTvLoading extends AiringTodayTvState {}

class AiringTodayTvLoaded extends AiringTodayTvState {
  final List<Tv> result;

  const AiringTodayTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class AiringTodayTvError extends AiringTodayTvState {
  const AiringTodayTvError(String message) : super(message: message);

  @override
  List<Object> get props => [message];
}
