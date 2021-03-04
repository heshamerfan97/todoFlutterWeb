import 'package:flutter/cupertino.dart';
import 'package:my_todo_list/Configurations/Preferences.dart';
import 'package:my_todo_list/Utils/PreferencesUtils.dart';
import 'package:my_todo_list/Utils/Translate.dart';

class LanguageRepository {
  static String translate(BuildContext context, String text)  {
    return Translate.of(context).translate(text);
  }

  static String getLanguage(){
    return PreferencesUtils.getString(Preferences.language);
  }
}