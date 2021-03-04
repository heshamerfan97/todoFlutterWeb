part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class OnAuthInit extends AuthenticationEvent {}
class OnAuthCheck extends AuthenticationEvent {}
class OnAuthAnonymous extends AuthenticationEvent {}
class OnAuthLogin extends AuthenticationEvent {
  final String email, password;

  OnAuthLogin(this.email, this.password);
}
class OnAuthRegister extends AuthenticationEvent {
  final String email, password;

  OnAuthRegister(this.email, this.password);
}

class OnSaveUser extends AuthenticationEvent {
  /*final User user;

  OnSaveUser(this.user);*/
}

class OnAuthAuthenticate extends AuthenticationEvent {}

class OnLogout extends AuthenticationEvent {}
class OnLogHimOut extends AuthenticationEvent {}