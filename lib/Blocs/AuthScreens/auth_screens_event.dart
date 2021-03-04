part of 'auth_screens_bloc.dart';

@immutable
abstract class AuthScreensEvent {}

class OnAuthScreensLogin extends AuthScreensEvent {}
class OnAuthScreensRegister extends AuthScreensEvent {}
