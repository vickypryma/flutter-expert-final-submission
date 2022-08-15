import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/season_response.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  const testSeasonResponse = SeasonResponse(testEpisodeModelList);
  const testSeasonResponseMap = {
    'episodes': [testEpisodeMap]
  };

  test('should return JSON map containing proper data', () {
    final result = testSeasonResponse.toJson();
    expect(result, testSeasonResponseMap);
  });
}
