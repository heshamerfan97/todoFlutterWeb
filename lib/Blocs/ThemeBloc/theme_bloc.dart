import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_todo_list/Configurations/Preferences.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Configurations/ThemeCollection.dart';
import 'package:my_todo_list/Models/Theme.dart';
import 'package:my_todo_list/Utils/PreferencesUtils.dart';

part 'theme_event.dart';
part 'theme_state.dart';

const DARK_DYNAMIC = 'dynamic';
const DARK_ALWAYS_OFF = 'off';
const DARK_ALWAYS_ON = 'on';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is OnChangeTheme) {
      yield ThemeUpdating();

      AppTheme.currentTheme = event.theme ?? AppTheme.currentTheme;
      AppTheme.currentFont = event.font ?? AppTheme.currentFont;
      AppTheme.darkThemeOption = event.darkOption ?? AppTheme.darkThemeOption;

      ///Setup Theme with setting darkOption
      switch (AppTheme.darkThemeOption) {
        case DarkOption.Dynamic:
          AppTheme.lightTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.lightTheme,
            font: AppTheme.currentFont,
          );
          AppTheme.darkTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.darkTheme,
            font: AppTheme.currentFont,
          );
          break;
        case DarkOption.AlwaysOn:
          AppTheme.lightTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.darkTheme,
            font: AppTheme.currentFont,
          );
          AppTheme.darkTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.darkTheme,
            font: AppTheme.currentFont,
          );
          break;
        case DarkOption.AlwaysOff:
          AppTheme.lightTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.lightTheme,
            font: AppTheme.currentFont,
          );
          AppTheme.darkTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.lightTheme,
            font: AppTheme.currentFont,
          );
          break;
        default:
          AppTheme.lightTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.lightTheme,
            font: AppTheme.currentFont,
          );
          AppTheme.darkTheme = ThemeCollection.getCollectionTheme(
            theme: AppTheme.currentTheme.darkTheme,
            font: AppTheme.currentFont,
          );
          break;
      }

      ///Preference save
      PreferencesUtils.setString(Preferences.theme, AppTheme.currentTheme.name);

      ///Preference save
      PreferencesUtils.setString(Preferences.font, AppTheme.currentFont);

      ///Preference save
      switch (AppTheme.darkThemeOption) {
        case DarkOption.Dynamic:
          PreferencesUtils.setString(Preferences.darkOption, DARK_DYNAMIC);
          break;
        case DarkOption.AlwaysOn:
          PreferencesUtils.setString(Preferences.darkOption, DARK_ALWAYS_ON);
          break;
        case DarkOption.AlwaysOff:
          PreferencesUtils.setString(Preferences.darkOption, DARK_ALWAYS_OFF);
          break;
        default:
          break;
      }

      ///Notification UI
      yield ThemeUpdated();
    }
  }
}
