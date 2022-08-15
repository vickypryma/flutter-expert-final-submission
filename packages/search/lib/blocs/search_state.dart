part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  final bool isMovie;
  final String query;
  final String message;

  const SearchState({this.isMovie = true, this.message = '', this.query = ''});

  @override
  List<Object?> get props => [isMovie, query, message];
}

class SearchEmpty extends SearchState {
  const SearchEmpty({isMovie = true, super.query}) : super(isMovie: isMovie);
}

class SearchLoading extends SearchState {
  const SearchLoading({super.isMovie});
}

class SearchLoaded extends SearchState {
  final List<dynamic> result;

  const SearchLoaded(
    this.result,
    String query, {
    super.isMovie,
  }) : super(query: query);

  @override
  List<Object> get props => [result, super.query, super.isMovie];
}

class SearchError extends SearchState {
  const SearchError(String message) : super(message: message);
}
