import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Preferences.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Models/Theme.dart';
import 'package:my_todo_list/Models/Device.dart';
import 'package:my_todo_list/Utils/PreferencesUtils.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial());

  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  Stream<ApplicationState> mapEventToState(
    ApplicationEvent event,
  ) async* {
    if (event is OnSetupApplication) {
      ///Pending loading to UI
      yield ApplicationWaiting();

      ///Initialize Firebase
      await Firebase.initializeApp();


      ///Setup SharedPreferences
      Application.preferences = await SharedPreferences.getInstance();

      ///Setting local storage path
      Application.storagePath = kIsWeb?'web':(await getApplicationDocumentsDirectory()).path;

      ///Read/Save Device Information
      Device device;
      try {
        if (Platform.isAndroid) {
          final android = await deviceInfoPlugin.androidInfo;
          device = Device(
            uuid: android.androidId,
            model: "Android",
            version: android.version.sdkInt.toString(),
            type: android.model,
          );
        } else if (Platform.isIOS) {
          final IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
          device = Device(
            uuid: ios.identifierForVendor,
            name: ios.name,
            model: ios.systemName,
            version: ios.systemVersion,
            type: ios.utsname.machine,
          );
        }
      } catch (e) {}
      Application.device = device;


      ////Get old Theme & Font & Language
      final oldTheme = PreferencesUtils.getString(Preferences.theme);
      final oldFont = PreferencesUtils.getString(Preferences.font);
      final oldLanguage = PreferencesUtils.getString(Preferences.language);
      final oldDarkOption = PreferencesUtils.getString(Preferences.darkOption);

      ThemeModel theme;
      String font;
      DarkOption darkOption;

      ///Setup Language
      if (oldLanguage != null) {
        AppBloc.languageBloc.add(
          OnChangeLanguage(locale: Locale(oldLanguage)),
        );
      }

      ///Find font support available
      final fontAvailable = AppTheme.fontSupport.where((item) {
        return item == oldFont;
      }).toList();

      ///Find theme support available
      final themeAvailable = AppTheme.themeSupport.where((item) {
        return item.name == oldTheme;
      }).toList();

      ///Check theme and font available
      if (fontAvailable.isNotEmpty) {
        font = fontAvailable[0];
      }

      if (themeAvailable.isNotEmpty) {
        theme = themeAvailable[0];
      }

      ///check old dark option
      if (oldDarkOption != null) {
        switch (oldDarkOption) {
          case DARK_ALWAYS_OFF:
            darkOption = DarkOption.AlwaysOff;
            break;
          case DARK_ALWAYS_ON:
            darkOption = DarkOption.AlwaysOn;
            break;
          default:
            darkOption = DarkOption.Dynamic;
        }
      }

      ///Setup Theme & Font with dark Option
      AppBloc.themeBloc.add(
        OnChangeTheme(
          theme: theme ?? AppTheme.currentTheme,
          font: font ?? AppTheme.currentFont,
          darkOption: darkOption ?? AppTheme.darkThemeOption,
        ),
      );

      ///Authentication begin check
      AppBloc.authenticationBloc.add(OnAuthInit());


      ///Become app
      yield ApplicationSetupCompleted();

    }
  }
}
