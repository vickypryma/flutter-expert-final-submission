import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:tv/domain/usecases/search_tv.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchMovies searchMovies;
  final SearchTv searchTv;

  SearchCubit({
    required this.searchMovies,
    required this.searchTv,
  }) : super(const SearchEmpty());

  changeType(bool isMovie) {
    emit(SearchEmpty(isMovie: isMovie, query: state.query));
    if (state.query.isNotEmpty) {
      _fetchSearch();
    }
  }

  Timer? timer;

  void onQueryChange(String query) {
    if (timer != null) timer!.cancel();

    if (query.isEmpty) {
      emit(SearchEmpty(isMovie: state.isMovie));
    } else {
      timer =
          Timer(const Duration(seconds: 1), () => _fetchSearch(query: query));
    }
  }

  Future<void> _fetchSearch({String? query}) async {
    final isMovie = state.isMovie;
    final searchQuery = query ??= state.query;
    emit(SearchLoading(isMovie: isMovie));

    final result = isMovie
        ? await searchMovies.execute(searchQuery)
        : await searchTv.execute(searchQuery);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (data) => emit(SearchLoaded(data, searchQuery, isMovie: isMovie)),
    );
  }
}
