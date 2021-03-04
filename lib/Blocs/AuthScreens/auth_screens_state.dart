part of 'auth_screens_bloc.dart';

@immutable
abstract class AuthScreensState {}

class AuthScreensInitial extends AuthScreensState {}
class AuthScreensLogin extends AuthScreensState {}
class AuthScreensRegister extends AuthScreensState {}
