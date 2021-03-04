part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationBeginCheck extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {
  final String from;
  final String message;

  AuthenticationFail({this.from, this.message});
}
