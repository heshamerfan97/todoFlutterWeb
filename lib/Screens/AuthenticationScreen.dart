import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:local_auth/local_auth.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';
import 'package:my_todo_list/Screens/WebAuthScreens/WebAuthenticationScreen.dart';

class AuthenticationScreen extends StatelessWidget {
  final LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    print('Build auth screen');
    return Application.storagePath=='web'?WebAuthenticationScreen():Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(Application.storagePath!='web')Text(LanguageRepository.translate(
                context, 'Press here to authenticate')),
            if(Application.storagePath!='web')IconButton(
              onPressed: () => _auth(context)
                 ,
              icon: Icon(Icons.fingerprint_outlined),
              iconSize: 56,
            ),
            if(Application.storagePath!='web')SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _skip,
              child: Text('Skip'),
            )
          ],
        ),
      ),
    );
  }

  _auth(BuildContext context) async {
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await localAuthentication.getAvailableBiometrics();
      bool didAuthenticate = false;
      if (availableBiometrics.contains(BiometricType.face)) {
        didAuthenticate = await localAuthentication.authenticate(
          biometricOnly: true,
            localizedReason: LanguageRepository.translate(context, 'Please authenticate to show account data'),
            stickyAuth: true);
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        didAuthenticate = await localAuthentication.authenticate(
          biometricOnly: true,
          localizedReason: LanguageRepository.translate(context, 'Please authenticate to show account data'),
          stickyAuth: true,
        );
      }
      if (didAuthenticate) {
        AppBloc.authenticationBloc.add(OnAuthAuthenticate());
        AppBloc.toDoBloc.add(OnTodoLoad());
      }
    }
  }

  _skip() {
    AppBloc.authenticationBloc.add(OnAuthAuthenticate());
    AppBloc.toDoBloc.add(OnTodoLoad());
  }
}
