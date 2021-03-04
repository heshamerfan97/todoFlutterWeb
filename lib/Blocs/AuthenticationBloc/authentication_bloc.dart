import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Configurations/Preferences.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Utils/PreferencesUtils.dart';
import 'package:my_todo_list/Models/User.dart' as userModel;

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    ///Initializing Firebase auth and listening to the user state
    if (event is OnAuthInit) {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          AppBloc.authenticationBloc.add(OnLogHimOut());
        } else {
          Application.firebaseUser = user;
          AppBloc.authenticationBloc.add(OnAuthCheck());
        }
      });
    }


    if (event is OnAuthAuthenticate) {
      final userPref = PreferencesUtils.getString(Preferences.user);
      if (userPref != null)
        Application.user = userModel.User.fromJson(json.decode(userPref));
      yield AuthenticationSuccess();
    }


    if (event is OnAuthCheck) {
      yield AuthenticationSuccess();
    }

    ///Creating new account
    if (event is OnAuthRegister) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          yield AuthenticationFail(from: 'Firebase', message: 'The password provided is too weak.');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          yield AuthenticationFail(from: 'Firebase', message: 'The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        yield AuthenticationFail(from: 'Firebase', message: e.toString());
        print(e);
      }
    }

    ///Login the user
    if (event is OnAuthLogin) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          yield AuthenticationFail(from: 'Firebase', message: 'No user found for that email.');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          yield AuthenticationFail(from: 'Firebase', message: 'Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        yield AuthenticationFail(from: 'Firebase', message: e.toString());
        print(e);
      }
    }

    ///Anonymous login so user can test the app
    if(event is OnAuthAnonymous){
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    }

    ///Signing the uer out
    if(event is OnLogout){
      await FirebaseAuth.instance.signOut();
      yield AuthenticationFail();
    }

    if(event is OnLogHimOut){
      yield AuthenticationFail();
    }
  }
}
