class Preferences{
  static String user = 'user';
  static String language = 'lang';
  static String theme = 'theme';
  static String darkOption = 'darkOption';
  static String font = 'font';
  static String toDos = 'toDos';


  ///Singleton factory
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
}