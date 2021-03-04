import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class AssetUtil {
  static Future<Map<String, dynamic>> loadJson(String path) async {
    String content = await rootBundle.loadString(path);
    return jsonDecode(content);
  }

  ///Singleton factory
  static final AssetUtil _instance = AssetUtil._internal();

  factory AssetUtil() {
    return _instance;
  }

  AssetUtil._internal();
}
