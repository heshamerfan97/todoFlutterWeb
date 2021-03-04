import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/Blocs/AuthScreens/auth_screens_bloc.dart';
import 'package:my_todo_list/Screens/WebAuthScreens/LandingScreen.dart';
import 'package:my_todo_list/Screens/WebAuthScreens/LoginScreen.dart';
import 'package:my_todo_list/Screens/WebAuthScreens/RegisterScreen.dart';

class WebAuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthScreensBloc, AuthScreensState>(
      builder: (context, authState) {
        if(authState is AuthScreensLogin)
        return LoginScreen();
        if(authState is AuthScreensRegister)
          return RegisterScreen();
        return LandingScreen();
      }
    );
  }
}
