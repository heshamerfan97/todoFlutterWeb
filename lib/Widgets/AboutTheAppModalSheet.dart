import 'package:flutter/material.dart';
import 'package:my_todo_list/Configurations/Application.dart';

class AboutTheAppModalSheet extends StatelessWidget {
  final String about =
      'A lot of text just to show in the about section, It should be too long so we can decide if it works correctly or it\'s just showing any issues, and this will decide if it will stay like that or will be changed';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          Application.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/app_icon.png', height: 120, width: 120,)),

            Text(
              about,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
