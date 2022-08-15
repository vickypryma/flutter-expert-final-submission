import 'dart:io';

String readJson(String name) {
  var dir = '${Directory.current.path}/';
  if (dir.endsWith('tv/')) {
    dir = Directory.current.parent.path;
    dir = dir.replaceAll('packages', '');
  }
  return File('${dir}packages/tv/test/$name').readAsStringSync();
}
