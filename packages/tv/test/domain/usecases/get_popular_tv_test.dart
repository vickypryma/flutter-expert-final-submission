import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetPopularTv useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = GetPopularTv(repository);
  });

  test('should get list of tv series from repository', () async {
    // arrange
    when(repository.getPopularTv())
        .thenAnswer((_) async => const Right(testTvList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, const Right(testTvList));
  });
}
