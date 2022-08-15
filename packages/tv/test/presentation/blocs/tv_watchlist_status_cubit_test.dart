import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';
import 'package:tv/presentation/blocs/tv_watchlist_status/tv_watchlist_status_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_status_cubit_test.mocks.dart';

@GenerateMocks([GetTvWatchlistStatus, SaveTvWatchlist, RemoveTvWatchlist])
void main() {
  late MockGetTvWatchlistStatus mockGetTvTvWatchlistStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late TvWatchlistStatusCubit cubit;

  setUp(() {
    mockGetTvTvWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    cubit = TvWatchlistStatusCubit(
      getTvWatchListStatus: mockGetTvTvWatchlistStatus,
      saveTvWatchlist: mockSaveTvWatchlist,
      removeTvWatchlist: mockRemoveTvWatchlist,
    );
  });

  blocTest<TvWatchlistStatusCubit, TvWatchlistStatusState>(
    'should get watchlist status',
    build: () {
      when(mockGetTvTvWatchlistStatus.execute(1))
          .thenAnswer((_) async => false);
      return cubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(1),
    expect: () => [const TvWatchlistStatusState(isAddedToWatchlist: false)],
    verify: (_) => verify(mockGetTvTvWatchlistStatus.execute(1)),
  );

  blocTest<TvWatchlistStatusCubit, TvWatchlistStatusState>(
    'should update watchlist status when add watchlist success',
    build: () {
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      return cubit;
    },
    act: (cubit) => cubit.addWatchlist(testTvDetail),
    expect: () => [
      const TvWatchlistStatusState(
        isAddedToWatchlist: true,
        message: 'Success',
      )
    ],
    verify: (_) => verify(mockSaveTvWatchlist.execute(testTvDetail)),
  );

  blocTest<TvWatchlistStatusCubit, TvWatchlistStatusState>(
    'should update watchlist message when add watchlist failed',
    build: () {
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return cubit;
    },
    act: (cubit) => cubit.addWatchlist(testTvDetail),
    expect: () => [
      const TvWatchlistStatusState(
        message: 'Failed',
      )
    ],
    verify: (_) => verify(mockSaveTvWatchlist.execute(testTvDetail)),
  );

  blocTest<TvWatchlistStatusCubit, TvWatchlistStatusState>(
    'should update watchlist status when remove watchlist success',
    build: () {
      when(mockRemoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      return cubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testTvDetail),
    expect: () => [
      const TvWatchlistStatusState(
        isAddedToWatchlist: false,
        message: 'Success',
      )
    ],
    verify: (_) => verify(mockRemoveTvWatchlist.execute(testTvDetail)),
  );

  blocTest<TvWatchlistStatusCubit, TvWatchlistStatusState>(
    'should update watchlist message when remove watchlist failed',
    build: () {
      when(mockRemoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return cubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testTvDetail),
    expect: () => [
      const TvWatchlistStatusState(
        message: 'Failed',
      )
    ],
    verify: (_) => verify(mockRemoveTvWatchlist.execute(testTvDetail)),
  );
}
