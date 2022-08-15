import 'dart:io';

import 'package:flutter/services.dart';

Future<SecurityContext> get securityContext async {
  final sslCert = await rootBundle.load('certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}
