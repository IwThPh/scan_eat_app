import 'package:flutter/material.dart';

class SlideBottomRoute extends PageRouteBuilder {
  final Widget page;
  SlideBottomRoute({this.page})
      : super(
          opaque: false,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionDuration: Duration(
            milliseconds: 1200,
          ),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCirc,
            );
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
        );
}
