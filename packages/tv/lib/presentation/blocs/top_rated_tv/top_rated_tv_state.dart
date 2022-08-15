part of 'top_rated_tv_cubit.dart';

abstract class TopRatedTvState extends Equatable {
  final String message;

  const TopRatedTvState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> result;

  const TopRatedTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvError extends TopRatedTvState {
  const TopRatedTvError(String message) : super(message: message);

  @override
  List<Object> get props => [message];
}
