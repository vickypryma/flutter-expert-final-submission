import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/presentation/blocs/watchlist_tv/watchlist_tv_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late WatchlistTvCubit cubit;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    cubit = WatchlistTvCubit(mockGetWatchlistTv);
  });

  blocTest<WatchlistTvCubit, WatchlistTvState>(
    'should emit [Loading, Loaded] when fetching tv is successful',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => const Right(testTvList));
      return cubit;
    },
    act: (cubit) => cubit.fetchWatchlistTv(),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvLoaded(testTvList),
    ],
    verify: (_) => verify(mockGetWatchlistTv.execute()),
  );

  blocTest<WatchlistTvCubit, WatchlistTvState>(
    'should emit [Loading, Error] when fetching tv is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => const Left(DatabaseFailure('failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchWatchlistTv(),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvError('failure'),
    ],
    verify: (_) => verify(mockGetWatchlistTv.execute()),
  );
}
