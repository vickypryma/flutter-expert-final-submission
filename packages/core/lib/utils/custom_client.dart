import 'dart:io';

import 'package:core/utils/security_context.dart';

class CustomClient {
  static late HttpClient _client;
  static HttpClient get client => _client;

  static Future<void> init() async {
    _client = HttpClient(context: await securityContext);
  }
}
