part of 'tv_detail_cubit.dart';

abstract class TvDetailState extends Equatable {
  final String message;

  const TvDetailState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tv;
  final List<Tv> recommendationTv;

  const TvDetailLoaded(this.tv, this.recommendationTv);

  @override
  List<Object> get props => [tv, recommendationTv];
}

class TvDetailError extends TvDetailState {
  const TvDetailError(String message) : super(message: message);

  @override
  List<Object> get props => [message];
}
