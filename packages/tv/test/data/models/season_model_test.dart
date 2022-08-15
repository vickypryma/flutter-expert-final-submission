import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should return JSON map containing proper data', () {
    final result = testSeasonModel.toJson();
    expect(result, testSeasonMap);
  });
}
