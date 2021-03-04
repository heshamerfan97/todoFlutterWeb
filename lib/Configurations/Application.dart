import 'package:my_todo_list/Configurations/Images.dart';
import 'package:my_todo_list/Configurations/Language.dart';
import 'package:my_todo_list/Models/Device.dart';
import 'package:my_todo_list/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class Application {
  static bool debug = true;
  static String version = '1.0.0';
  static SharedPreferences preferences;
  static String deviceType;
  static Device device;
  static bool isEnglish = AppLanguage.defaultLanguage.languageCode == 'en';
  static String storagePath = '';
  static User user = User();
  static firebaseAuth.User firebaseUser;

  static const List<String> TodoAssets = [
    Images.asset0,
    Images.asset1,
    Images.asset2,
    Images.asset3,
    Images.asset4,
    Images.asset5,
    Images.asset6,
    Images.asset7,
    Images.asset8
  ];

  static const List<int> TodoColors = [
    0xFFE4FbFF,
    0xFFB8B5FF,
    0xFF7868E6,
    0xFFEDEEF7,
    0xFF413C69,
    0xFF4A47A3,
    0xFFA7C5EB,
    0xFF709FB0,
    0xFF26001B,
    0xFF810034,
    0xFFFF005C,
    0xFFFFF600,
    0xFFFF75A0,
    0xFFB34180,
  ];

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
