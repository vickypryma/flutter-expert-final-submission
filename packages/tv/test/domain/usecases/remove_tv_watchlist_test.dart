import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = RemoveTvWatchlist(repository);
  });

  test('should remove tv series from watchlist', () async {
    // arrange
    when(repository.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Success'));
    // act
    final result = await useCase.execute(testTvDetail);
    // assert
    expect(result, const Right('Success'));
  });
}
