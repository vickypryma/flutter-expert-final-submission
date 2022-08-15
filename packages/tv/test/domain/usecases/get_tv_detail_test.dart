import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvDetail useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = GetTvDetail(repository);
  });

  test('should get tv series detail from repository', () async {
    // arrange
    const tId = 1;
    when(repository.getTvDetail(tId))
        .thenAnswer((_) async => const Right(testTvDetail));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, const Right(testTvDetail));
  });
}
