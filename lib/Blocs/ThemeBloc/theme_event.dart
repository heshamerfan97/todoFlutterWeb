part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class OnChangeTheme extends ThemeEvent {
  final ThemeModel theme;
  final String font;
  final DarkOption darkOption;

  OnChangeTheme({
    this.theme,
    this.font,
    this.darkOption,
  });
}