import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/blocs/watchlist_status/watchlist_status_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_status_cubit_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistStatusCubit cubit;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    cubit = WatchlistStatusCubit(
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  blocTest<WatchlistStatusCubit, WatchlistStatusState>(
    'should get watchlist status',
    build: () {
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => false);
      return cubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(1),
    expect: () => [const WatchlistStatusState(isAddedToWatchlist: false)],
    verify: (_) => verify(mockGetWatchlistStatus.execute(1)),
  );

  blocTest<WatchlistStatusCubit, WatchlistStatusState>(
    'should update watchlist status when add watchlist success',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Success'));
      return cubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistStatusState(
        isAddedToWatchlist: true,
        message: 'Success',
      )
    ],
    verify: (_) => verify(mockSaveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistStatusCubit, WatchlistStatusState>(
    'should update watchlist message when add watchlist failed',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return cubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistStatusState(
        message: 'Failed',
      )
    ],
    verify: (_) => verify(mockSaveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistStatusCubit, WatchlistStatusState>(
    'should update watchlist status when remove watchlist success',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Success'));
      return cubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistStatusState(
        isAddedToWatchlist: false,
        message: 'Success',
      )
    ],
    verify: (_) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistStatusCubit, WatchlistStatusState>(
    'should update watchlist message when remove watchlist failed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return cubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistStatusState(
        message: 'Failed',
      )
    ],
    verify: (_) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
  );
}
