import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_episodes.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetEpisodes useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = GetEpisodes(repository);
  });

  test('should get season detail from repository', () async {
    // arrange
    when(repository.getEpisodes(1, 1))
        .thenAnswer((_) async => const Right(testEpisodeList));
    // act
    final result = await useCase.execute(1, 1);
    // assert
    expect(result, const Right(testEpisodeList));
  });
}
