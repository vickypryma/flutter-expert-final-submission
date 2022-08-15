import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = SaveTvWatchlist(repository);
  });

  test('should add tv series to watchlist', () async {
    // arrange
    when(repository.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Success'));
    // act
    final result = await useCase.execute(testTvDetail);
    // assert
    expect(result, const Right('Success'));
  });
}
