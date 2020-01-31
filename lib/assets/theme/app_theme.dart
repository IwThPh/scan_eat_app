import 'package:flutter/material.dart';

export 'colours.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 112.0, fontWeight: FontWeight.w100),
      headline2: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w400),
      headline3: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400),
      headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400),
      headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
      button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
    ),
  );
}
