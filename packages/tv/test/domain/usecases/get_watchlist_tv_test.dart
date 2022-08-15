import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetWatchlistTv useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = GetWatchlistTv(repository);
  });

  test('should get list of tv series from repository', () async {
    // arrange
    when(repository.getWatchlistTv())
        .thenAnswer((_) async => const Right(testTvList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, const Right(testTvList));
  });
}
