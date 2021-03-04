import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/ThemeBloc/theme_bloc.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';

class FontModalSheet extends StatefulWidget {
  @override
  _FontModalSheetState createState() => _FontModalSheetState();
}

class _FontModalSheetState extends State<FontModalSheet> {
  String currentFont = AppTheme.currentFont;

  @override
  Widget build(BuildContext context) {
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
              LanguageRepository.translate(context, 'Choose a font'),
              style: textTheme.headline5,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButton(
                items: AppTheme.fontSupport
                    .map((font) => DropdownMenuItem(
                          child: Text(
                            'أبجدهوز   $font',
                            style: TextStyle(fontFamily: font),
                          ),
                          value: font,
                        ))
                    .toList(),
                onChanged: (font) {
                  setState(() {
                    currentFont = font;
                  });
                  print(font);
                },
                value: currentFont,
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
                  onPressed: _changeFont),
            ),
          ],
        ),
      ),
    );
  }

  _changeFont() async {
    AppBloc.themeBloc.add(OnChangeTheme(
        darkOption: AppTheme.darkThemeOption,
        font: currentFont,
        theme: AppTheme.currentTheme));
    Navigator.of(context).pop();
  }
}
