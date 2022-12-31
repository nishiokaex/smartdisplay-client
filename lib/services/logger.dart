import 'package:flutter/foundation.dart';

abstract class Logger {
  static Logger self = kIsWeb ? _WebLogger() : _NativeLogger();

  static error(Object exception, [StackTrace? stackTrace]) {
    self.errorImpl(exception, stackTrace);
  }

  static warn(Object obj) {
    self.warnImpl(obj);
  }

  static info(Object obj) {
    self.infoImpl(obj);
  }

  errorImpl(Object exception, [StackTrace? stackTrace]);
  warnImpl(Object obj);
  infoImpl(Object obj);
}

class _WebLogger extends Logger {
  static const bool isProd = bool.fromEnvironment('dart.vm.product');

  @override
  errorImpl(Object exception, [StackTrace? stackTrace]) {
    // productionでもログを出す
    print('[ERROR] ${exception.toString()}');
    print('[ERROR] ${stackTrace.toString()}');
  }

  @override
  warnImpl(Object obj) {
    if (kDebugMode) {
      print('[WARN] ${obj.toString()}');
    }
  }

  @override
  infoImpl(Object obj) {
    if (kDebugMode) {
      print('[INFO] ${obj.toString()}');
    }
  }
}

class _NativeLogger extends Logger {
  @override
  errorImpl(Object exception, [StackTrace? stackTrace]) async {
    // productionでもログを出す
    print('[ERROR] ${exception.toString()}');
    print('[ERROR] ${stackTrace.toString()}');
  }

  @override
  warnImpl(Object obj) {
    if (kDebugMode) {
      print('[WARN] ${obj.toString()}');
    }
  }

  @override
  infoImpl(Object obj) {
    if (kDebugMode) {
      print('[INFO] ${obj.toString()}');
    }
  }
}
