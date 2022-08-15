import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/blocs/popular_tv/popular_tv_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvCubit cubit;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    cubit = PopularTvCubit(mockGetPopularTv);
  });

  blocTest<PopularTvCubit, PopularTvState>(
    'should emit [Loading, Loaded] when fetching tv is successful',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Right(testTvList));
      return cubit;
    },
    act: (cubit) => cubit.fetchPopularTv(),
    expect: () => [
      PopularTvLoading(),
      const PopularTvLoaded(testTvList),
    ],
    verify: (_) => verify(mockGetPopularTv.execute()),
  );

  blocTest<PopularTvCubit, PopularTvState>(
    'should emit [Loading, Error] when fetching tv is unsuccessful',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchPopularTv(),
    expect: () => [
      PopularTvLoading(),
      const PopularTvError('failure'),
    ],
    verify: (_) => verify(mockGetPopularTv.execute()),
  );
}
