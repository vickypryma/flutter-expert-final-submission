import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_episodes.dart';
import 'package:tv/presentation/blocs/season_episodes/season_episodes_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'season_episodes_cubit_test.mocks.dart';

@GenerateMocks([GetEpisodes])
void main() {
  late MockGetEpisodes mockGetEpisodes;
  late SeasonEpisodesCubit cubit;

  setUp(() {
    mockGetEpisodes = MockGetEpisodes();
    cubit = SeasonEpisodesCubit(mockGetEpisodes);
  });

  blocTest<SeasonEpisodesCubit, SeasonEpisodesState>(
    'should emit [Loading, Loaded] when fetching episodes is successful',
    build: () {
      when(mockGetEpisodes.execute(1, 1))
          .thenAnswer((_) async => const Right(testEpisodeList));
      return cubit;
    },
    act: (cubit) => cubit.fetchEpisodes(1, 1),
    expect: () => [
      SeasonEpisodesLoading(),
      const SeasonEpisodesLoaded(testEpisodeList),
    ],
    verify: (_) => verify(mockGetEpisodes.execute(1, 1)),
  );

  blocTest<SeasonEpisodesCubit, SeasonEpisodesState>(
    'should emit [Loading, Error] when fetching episodes is unsuccessful',
    build: () {
      when(mockGetEpisodes.execute(1, 1))
          .thenAnswer((_) async => const Left(ServerFailure('failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchEpisodes(1, 1),
    expect: () => [
      SeasonEpisodesLoading(),
      const SeasonEpisodesError('failure'),
    ],
    verify: (_) => verify(mockGetEpisodes.execute(1, 1)),
  );
}
