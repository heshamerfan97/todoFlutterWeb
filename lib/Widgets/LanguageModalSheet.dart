import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/LanguageBloc/language_bloc.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';

class LanguageModalSheet extends StatefulWidget {
  @override
  _LanguageModalSheetState createState() => _LanguageModalSheetState();
}

class _LanguageModalSheetState extends State<LanguageModalSheet> {
  String language = Application.isEnglish ? 'en' : 'ar';

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
              LanguageRepository.translate(context, 'Choose a language'),
              style: textTheme.headline5,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/ar_icon.png',
                            height: 20,
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'العربية',
                              textAlign: TextAlign.center,
                              style: textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: 'ar',
                  ),
                  DropdownMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/en_icon.png',
                            height: 20,
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'English',
                              textAlign: TextAlign.center,
                              style: textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: 'en',
                  )
                ],
                onChanged: (lang) {
                  setState(() {
                    language = lang;
                  });
                  print(language);
                },
                value: language,
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
                  onPressed: _changeLanguage),
            ),
          ],
        ),
      ),
    );
  }

  _changeLanguage() async {
    AppBloc.languageBloc.add(OnChangeLanguage(locale: Locale(language)));
    Navigator.of(context).pop();
  }
}