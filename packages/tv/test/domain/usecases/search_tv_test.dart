import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/search_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SearchTv useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = SearchTv(repository);
  });

  test('should get list of tv series from repository', () async {
    // arrange
    const tQuery = 'test';
    when(repository.searchTv(tQuery))
        .thenAnswer((_) async => const Right(testTvList));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, const Right(testTvList));
  });
}
