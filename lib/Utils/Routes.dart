import 'package:flutter/material.dart';
import 'package:my_todo_list/Screens/Screens.dart';

class Routes {
  static const String MAIN_SETTINGS = '/main-settings';
  static const String PROFILE_DATA_SCREEN = '/profile-data-screen';


  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MAIN_SETTINGS:
        return MaterialPageRoute(
          builder: (context) {
            return MainSettings();
          },
          fullscreenDialog: true,
        );


      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}