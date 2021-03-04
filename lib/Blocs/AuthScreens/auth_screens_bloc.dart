import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_screens_event.dart';
part 'auth_screens_state.dart';

class AuthScreensBloc extends Bloc<AuthScreensEvent, AuthScreensState> {
  AuthScreensBloc() : super(AuthScreensInitial());

  @override
  Stream<AuthScreensState> mapEventToState(
    AuthScreensEvent event,
  ) async* {
    if(event is OnAuthScreensLogin)
      yield AuthScreensLogin();
    if(event is OnAuthScreensRegister)
      yield AuthScreensRegister();
  }
}
