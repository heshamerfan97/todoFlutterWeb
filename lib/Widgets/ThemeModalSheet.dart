import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/ThemeBloc/theme_bloc.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';

class ThemeModalSheet extends StatefulWidget {
  @override
  _ThemeModalSheetState createState() => _ThemeModalSheetState();
}

class _ThemeModalSheetState extends State<ThemeModalSheet> {
  String currentTheme = AppTheme.currentTheme.name;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> themes =
    AppTheme.themeSupport.map((theme) => {'name': theme.name, 'color': theme.color}).toList();
    final textTheme = Theme.of(context).textTheme;
    return Directionality(
      textDirection:
      Application.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LanguageRepository.translate(context, 'Choose a theme'),
              style: textTheme.headline5,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButton(
                items: themes
                    .map((theme) => DropdownMenuItem(
                  child: Text(
                    theme['name'],
                    style: TextStyle(color: theme['color']),
                  ),
                  value: theme['name'],
                ))
                    .toList(),
                onChanged: (themeName) {
                  setState(() {
                    currentTheme = themeName;
                  });
                  print(currentTheme);
                },
                value: currentTheme,
                isExpanded: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),),
                  child: Text(
                    LanguageRepository.translate(context, 'Save'),
                    style: textTheme.headline6,
                  ),
                  onPressed: _changeTheme),
            ),
          ],
        ),
      ),
    );
  }

  _changeTheme() async {
    final themeAvailable = AppTheme.themeSupport.where((item) {
      return item.name == currentTheme;
    }).toList();
    AppBloc.themeBloc.add(OnChangeTheme(
        darkOption: AppTheme.darkThemeOption,
        font: AppTheme.currentFont,
        theme: themeAvailable[0]));
    Navigator.of(context).pop();
  }
}
