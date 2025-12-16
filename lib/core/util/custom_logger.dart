import 'dart:convert';
import 'dart:developer';

class CustomLogger {
  static void p(Object? m, {String? message}) {
    if (message != null) {
      log('$message : ${json.encode(m)}');
    } else {
      log(jsonEncode(m));
    }
  }

  static void pP(Object? m, {String? message}) {
    if (message != null) {
      log('$message : ${const JsonEncoder.withIndent('  ').convert(m)}');
    } else {
      log(const JsonEncoder.withIndent('  ').convert(m));
    }
  }
}
