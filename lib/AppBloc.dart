import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';

class AppBloc {
  static final applicationBloc = ApplicationBloc();
  static final languageBloc = LanguageBloc();
  static final authenticationBloc = AuthenticationBloc();
  static final themeBloc = ThemeBloc();
  static final toDoBloc = TodoBloc();
  static final authScreensBloc = AuthScreensBloc();


  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<LanguageBloc>(
      create: (context) => languageBloc,
    ),
    BlocProvider<AuthenticationBloc>(
      create: (context) => authenticationBloc,
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<TodoBloc>(
      create: (context) => toDoBloc,
    ),
    BlocProvider<AuthScreensBloc>(
      create: (context) => authScreensBloc,
    ),
  ];

  static void dispose() {
    applicationBloc.close();
    languageBloc.close();
    authenticationBloc.close();
    themeBloc.close();
    toDoBloc.close();
    authScreensBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
