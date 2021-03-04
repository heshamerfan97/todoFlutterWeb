import 'dart:developer' as developer;

import 'package:my_todo_list/Configurations/Application.dart';


class UtilLogger {
  static const String TAG = "Forera Delivery:";

  static log([String tag = TAG, dynamic msg]) {
    if (Application.debug) {
      developer.log('$msg', name: tag);
    }
  }

  ///Singleton factory
  static final UtilLogger _instance = UtilLogger._internal();

  factory UtilLogger() {
    return _instance;
  }

  UtilLogger._internal();
}
