import 'dart:io';

String readJson(String name) {
  var dir = '${Directory.current.path}/';
  if (dir.endsWith('movie/')) {
    dir = Directory.current.parent.path;
    dir = dir.replaceAll('packages', '');
  }
  return File('${dir}packages/movie/test/$name').readAsStringSync();
}
