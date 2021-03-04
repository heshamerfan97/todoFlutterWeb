import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Language.dart';
import 'package:my_todo_list/Configurations/Preferences.dart';
import 'package:my_todo_list/Utils/PreferencesUtils.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial());

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is OnChangeLanguage) {
      Application.isEnglish = event.locale.languageCode == 'en';
      if (event.locale == AppLanguage.defaultLanguage) {
        yield LanguageUpdated();
      } else {
        yield LanguageUpdating();
        AppLanguage.defaultLanguage = event.locale;

        ///Preference save
        PreferencesUtils.setString(
          Preferences.language,
          event.locale.languageCode,
        );

        yield LanguageUpdated();
      }
    }
  }
}
