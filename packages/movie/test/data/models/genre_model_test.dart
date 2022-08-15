import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';

void main() {
  const tGenreModel = GenreModel(id: 1, name: 'name');
  final tGenreMap = {'id': 1, 'name': 'name'};

  test('should return JSON map containing proper data', () {
    final result = tGenreModel.toJson();
    expect(result, tGenreMap);
  });
}
