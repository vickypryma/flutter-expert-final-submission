import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = GetTopRatedTv(repository);
  });

  test('should get list of tv series from repository', () async {
    // arrange
    when(repository.getTopRatedTv())
        .thenAnswer((_) async => const Right(testTvList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, const Right(testTvList));
  });
}
