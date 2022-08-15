import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_airing_today_tv.dart';
import 'package:tv/presentation/blocs/airing_today_tv/airing_today_tv_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_tv_cubit_test.mocks.dart';

@GenerateMocks([GetAiringTodayTv])
void main() {
  late MockGetAiringTodayTv mockGetAiringTodayTv;
  late AiringTodayTvCubit cubit;

  setUp(() {
    mockGetAiringTodayTv = MockGetAiringTodayTv();
    cubit = AiringTodayTvCubit(mockGetAiringTodayTv);
  });

  blocTest<AiringTodayTvCubit, AiringTodayTvState>(
    'should emit [Loading, Loaded] when fetching tv is successful',
    build: () {
      when(mockGetAiringTodayTv.execute())
          .thenAnswer((_) async => const Right(testTvList));
      return cubit;
    },
    act: (cubit) => cubit.fetchAiringTodayTv(),
    expect: () => [
      AiringTodayTvLoading(),
      const AiringTodayTvLoaded(testTvList),
    ],
    verify: (_) => verify(mockGetAiringTodayTv.execute()),
  );

  blocTest<AiringTodayTvCubit, AiringTodayTvState>(
    'should emit [Loading, Error] when fetching tv is unsuccessful',
    build: () {
      when(mockGetAiringTodayTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchAiringTodayTv(),
    expect: () => [
      AiringTodayTvLoading(),
      const AiringTodayTvError('failure'),
    ],
    verify: (_) => verify(mockGetAiringTodayTv.execute()),
  );
}
