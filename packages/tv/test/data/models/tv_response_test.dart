import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  const testTvResponse = TvResponse(tvList: testTvModelList);
  const testTvResponseMap = {
    'results': [testTvMap]
  };

  test('should return JSON map containing proper data', () {
    final result = testTvResponse.toJson();
    expect(result, testTvResponseMap);
  });
}
