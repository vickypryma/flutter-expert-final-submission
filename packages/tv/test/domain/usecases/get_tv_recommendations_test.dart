import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = GetTvRecommendations(repository);
  });

  test('should get list of tv series from repository', () async {
    // arrange
    const tId = 1;
    when(repository.getTvRecommendations(tId))
        .thenAnswer((_) async => const Right(testTvList));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, const Right(testTvList));
  });
}
