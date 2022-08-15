part of 'popular_tv_cubit.dart';

abstract class PopularTvState extends Equatable {
  final String message;

  const PopularTvState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class PopularTvEmpty extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<Tv> result;

  const PopularTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class PopularTvError extends PopularTvState {
  const PopularTvError(String message) : super(message: message);

  @override
  List<Object> get props => [message];
}
