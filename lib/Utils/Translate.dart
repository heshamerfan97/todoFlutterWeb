import 'package:flutter/material.dart';
import 'package:my_todo_list/AppLocaleDelegate.dart';
import 'package:my_todo_list/Utils/Asset.dart';


class Translate {
  final Locale locale;

  Translate(this.locale);

  static Translate of(BuildContext context) {
    return Localizations.of<Translate>(context, Translate);
  }

  static const LocalizationsDelegate<Translate> delegate = AppLocaleDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    final jsonMap = await AssetUtil.loadJson(
      "assets/lang/${locale.languageCode}.json",
    );

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}