part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class OnChangeLanguage extends LanguageEvent {
  final Locale locale;

  OnChangeLanguage({this.locale});
}