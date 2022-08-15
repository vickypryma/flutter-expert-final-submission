import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvWatchlistStatus useCase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    useCase = GetTvWatchlistStatus(repository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(repository.isAddedToTvWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await useCase.execute(1);
    // assert
    expect(result, true);
  });
}
