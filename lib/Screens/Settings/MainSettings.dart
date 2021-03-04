import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';
import 'package:my_todo_list/Utils/Routes.dart';
import 'package:my_todo_list/Widgets/AboutTheAppModalSheet.dart';
import 'package:my_todo_list/Widgets/FontModalSheet.dart';
import 'package:my_todo_list/Widgets/LanguageModalSheet.dart';
import 'package:my_todo_list/Widgets/SettingsTileWidget.dart';
import 'package:my_todo_list/Widgets/ThemeModalSheet.dart';

// ignore: must_be_immutable
class MainSettings extends StatelessWidget {
  bool darkModeOn;
  @override
  Widget build(BuildContext context) {
    final brightness =
        SchedulerBinding.instance.window.platformBrightness;
    darkModeOn = brightness == Brightness.dark;
    final colors = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          LanguageRepository.translate(context, 'Settings'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 90,
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    child: Icon(
                      Icons.person,
                      color: colors.primaryColor,
                      size: 60,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    Application.user.name,
                    style: textTheme.headline5,
                  ),
                  /*Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Application.user.name,
                            style: textTheme.headline4,
                          ),
                          Text(
                            '${Application.user.phone}',
                            style: textTheme.subtitle1,
                          )
                        ],
                      )*/
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SettingsTileWidget(
              title: LanguageRepository.translate(context, 'Profile'),
              icon: Icons.person_outline,
              user: Application.user,
              routeName: Routes.PROFILE_DATA_SCREEN,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: ListTile(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Coming Soon..',
                    style: textTheme.headline5.copyWith(color: Colors.white),
                  ),
                  backgroundColor: colors.primaryColor,
                )),
                dense: true,
                title: Text(
                  LanguageRepository.translate(context, 'Payment Options'),
                  style: textTheme.headline6,
                ),
                leading: Icon(Icons.credit_card),
                trailing: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: colors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: colors.primaryColor,
                    size: 14,
                  ),
                ),
              ),
            ),
            /*SettingsTileWidget(
                  title: LanguageRepository.translate(context, 'Contact us'),
                  icon: Icons.message_outlined,
                  user: user,
                  routeName: Routes.CHAT_SCREEN,
                ),*/
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: ListTile(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    height: 200,
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: LanguageModalSheet(),
                    ),
                  ),
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  isScrollControlled: true,
                ),
                dense: true,
                title: Text(
                  LanguageRepository.translate(context, 'Language'),
                  style: textTheme.headline6,
                ),
                leading: Icon(Icons.language),
                trailing: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: colors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: colors.primaryColor,
                    size: 14,
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: ListTile(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    height: 200,
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      //TODO: Change This
                      child: ThemeModalSheet(),
                    ),
                  ),
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  isScrollControlled: true,
                ),
                dense: true,
                title: Text(
                  LanguageRepository.translate(context, 'Theme'),
                  style: textTheme.headline6,
                ),
                leading: Icon(Icons.category),
                trailing: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: colors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: colors.primaryColor,
                    size: 14,
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: ListTile(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    height: 200,
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: FontModalSheet(),
                    ),
                  ),
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  isScrollControlled: true,
                ),
                dense: true,
                title: Text(
                  LanguageRepository.translate(context, 'Font'),
                  style: textTheme.headline6,
                ),
                leading: Icon(Icons.font_download_outlined),
                trailing: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: colors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: colors.primaryColor,
                    size: 14,
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: ListTile(
                onTap: _changeMode ,
                dense: true,
                title: Text(
                  LanguageRepository.translate(context, 'Dark mode'),
                  style: textTheme.headline6,
                ),
                leading: Icon(Icons.brightness_3_sharp),
                trailing: Switch(value: AppTheme.darkThemeOption == DarkOption.Dynamic?darkModeOn:AppTheme.darkThemeOption == DarkOption.AlwaysOn, onChanged: (value) => _changeMode())
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: ListTile(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    height: 500,
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: AboutTheAppModalSheet(),
                    ),
                  ),
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  isScrollControlled: true,
                ),
                dense: true,
                title: Text(
                  LanguageRepository.translate(context, 'About the App'),
                  style: textTheme.headline6,
                ),
                leading: Icon(Icons.info_outline),
                trailing: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: colors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: colors.primaryColor,
                    size: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                LanguageRepository.translate(context, 'Logout'),
                style: textTheme.headline6,
              ),
              onTap: () async {
                AppBloc.authenticationBloc.add(OnLogout());
                /*print('pressed');
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.remove('userData');
                final removed = await pref.remove('cart');
                print('removed: $removed');
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.LOGIN_SCREEN, (route) => false);*/
              },
            )
          ],
        ) /*;*/
            /*}),*/
            ),
      ),
    );
  }

  _changeMode(){

    AppBloc.themeBloc.add(OnChangeTheme(
        theme: AppTheme.currentTheme,
        font: AppTheme.currentFont,
        darkOption: AppTheme.darkThemeOption == DarkOption.Dynamic
            ? (darkModeOn
            ? DarkOption.AlwaysOff
            : DarkOption.AlwaysOn)
            : AppTheme.darkThemeOption == DarkOption.AlwaysOn
            ? DarkOption.AlwaysOff
            : DarkOption.AlwaysOn));
  }
}
