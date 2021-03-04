class Images {
  ///Online images base url
  static const String ImageUrl = 'https://forera-app.com/storage/';

  static const String ArabicIcon = "assets/images/ar_icon.png";
  static const String EnglishIcon = "assets/images/en_icon.png";
  static const String Logo = "assets/images/app_icon.png";


  ///Assets shown in todo
  static const String asset0 = "assets/images/assets/asset0.png";
  static const String asset1 = "assets/images/assets/asset1.png";
  static const String asset2 = "assets/images/assets/asset2.png";
  static const String asset3 = "assets/images/assets/asset3.png";
  static const String asset4 = "assets/images/assets/asset4.png";
  static const String asset5 = "assets/images/assets/asset5.png";
  static const String asset6 = "assets/images/assets/asset6.png";
  static const String asset7 = "assets/images/assets/asset7.png";
  static const String asset8 = "assets/images/assets/asset8.png";



  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
