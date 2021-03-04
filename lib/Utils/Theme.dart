import 'package:my_todo_list/Configurations/Theme.dart';

class UtilTheme {
  static String exportLangTheme(DarkOption option) {
    switch (option) {
      case DarkOption.Dynamic:
        return "dynamic_theme";
      case DarkOption.AlwaysOff:
        return "always_off";
      default:
        return "always_on";
    }
  }

  ///Singleton factory
  static final UtilTheme _instance = UtilTheme._internal();

  factory UtilTheme() {
    return _instance;
  }

  UtilTheme._internal();
}
