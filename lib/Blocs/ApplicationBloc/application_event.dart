part of 'application_bloc.dart';

@immutable
abstract class ApplicationEvent {}

///Event notification setup application
class OnSetupApplication extends ApplicationEvent {}
