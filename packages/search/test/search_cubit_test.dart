import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:search/blocs/search_cubit.dart';
import 'package:tv/domain/usecases/search_tv.dart';

import 'dummy_objects.dart';
import 'search_cubit_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTv])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MockSearchTv mockSearchTv;
  late SearchCubit searchCubit;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTv = MockSearchTv();
    searchCubit = SearchCubit(
      searchMovies: mockSearchMovies,
      searchTv: mockSearchTv,
    );
  });

  const tQuery = 'test';

  blocTest<SearchCubit, SearchState>(
    'should emit [Empty] when changing search type',
    build: () => searchCubit,
    act: (cubit) => cubit.changeType(false),
    expect: () => [const SearchEmpty(isMovie: false)],
  );

  blocTest<SearchCubit, SearchState>(
    'should emit [Empty] when query is empty',
    build: () => searchCubit,
    act: (cubit) => cubit.onQueryChange(''),
    expect: () => [const SearchEmpty()],
  );

  blocTest<SearchCubit, SearchState>(
    'should emit [Loading, Loaded] when fetching data is successful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right([testMovie]));
      return searchCubit;
    },
    act: (cubit) => cubit.onQueryChange(tQuery),
    wait: const Duration(seconds: 1),
    expect: () => [
      const SearchLoading(),
      SearchLoaded([testMovie], tQuery),
    ],
    verify: (_) => verify(mockSearchMovies.execute(tQuery)),
  );

  blocTest<SearchCubit, SearchState>(
    'should emit [Loading, Error] when fetching data is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return searchCubit;
    },
    act: (cubit) => cubit.onQueryChange(tQuery),
    wait: const Duration(seconds: 1),
    expect: () => [
      const SearchLoading(),
      const SearchError(''),
    ],
    verify: (_) => verify(mockSearchMovies.execute(tQuery)),
  );
}
