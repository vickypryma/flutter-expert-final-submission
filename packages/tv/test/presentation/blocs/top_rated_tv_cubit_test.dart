import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv/presentation/blocs/top_rated_tv/top_rated_tv_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvCubit cubit;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    cubit = TopRatedTvCubit(mockGetTopRatedTv);
  });

  blocTest<TopRatedTvCubit, TopRatedTvState>(
    'should emit [Loading, Loaded] when fetching tv is successful',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Right(testTvList));
      return cubit;
    },
    act: (cubit) => cubit.fetchTopRatedTv(),
    expect: () => [
      TopRatedTvLoading(),
      const TopRatedTvLoaded(testTvList),
    ],
    verify: (_) => verify(mockGetTopRatedTv.execute()),
  );

  blocTest<TopRatedTvCubit, TopRatedTvState>(
    'should emit [Loading, Error] when fetching tv is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchTopRatedTv(),
    expect: () => [
      TopRatedTvLoading(),
      const TopRatedTvError('failure'),
    ],
    verify: (_) => verify(mockGetTopRatedTv.execute()),
  );
}
