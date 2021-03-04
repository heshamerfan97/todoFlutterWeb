import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/AuthScreens/auth_screens_bloc.dart';
import 'package:my_todo_list/Utils/DleayedAnimation.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = '/purple_animation_main_screen';

  @override
  _LandingScreenState createState() =>
      _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
        //backgroundColor: Color(0xFF8185E2),
        body: Stack(
          children: [
            Positioned.fill(child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(
                end: Alignment.topRight,
                begin: Alignment.bottomLeft,
                colors: [
                  Color(0xFF8185E2),
                  Color(0xFF28B8D5),
                ]
            )),
          )),
            Positioned.fill(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 90,
                      duration: Duration(seconds: 2),
                      glowColor: Colors.white24,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 2),
                      startDelay: Duration(seconds: 1),
                      child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: FlutterLogo(
                              size: 50.0,
                            ),
                            radius: 50.0,
                          )),
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Hi There",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: color),
                      ),
                      delay: delayedAmount + 1000,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "I'm Todo by Flutter Web",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: color),
                      ),
                      delay: delayedAmount + 2000,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "The Best Place",
                        style: TextStyle(fontSize: 20.0, color: color),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "To plan your day",
                        style: TextStyle(fontSize: 20.0, color: color),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    DelayedAnimation(
                      child: GestureDetector(
                        onTap: () => AppBloc.authScreensBloc.add(OnAuthScreensRegister()),
                        child: Transform.scale(
                          scale: _scale,
                          child: _animatedButtonUI,
                        ),
                      ),
                      delay: delayedAmount + 4000,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    DelayedAnimation(
                      child: GestureDetector(
                        onTap: () => AppBloc.authScreensBloc.add(OnAuthScreensLogin()),
                        child: Text(
                          "I Already have An Account".toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: color),
                        ),
                      ),
                      delay: delayedAmount + 5000,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child:
    Center(
      child: Text(
        'Hi Todo',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8185E2),
        ),
      ),
    ),
  );

}