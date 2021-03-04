import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {

  final WidgetBuilder _builder;

  HeroDialogRoute({
   @required  WidgetBuilder builder,
    RouteSettings settings,
    bool fullScreenDialog = false,
}) : _builder = builder, super(settings: settings, fullscreenDialog: fullScreenDialog);


  @override
  bool get opaque => false;


  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 700);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => 'Popup dialog open';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => _builder(context);


  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) => child;


}