import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';

export 'colours.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colours.primary,
    accentColor: Colours.green,
    cursorColor: Colours.primaryAccent,
    splashColor: Colours.primary,
    backgroundColor: Colours.offWhite,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      //See https://api.flutter.dev/flutter/material/TextTheme-class.html for details.
      display4: TextStyle(fontSize: 112.0, fontWeight: FontWeight.w100),
      display3: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w400),
      display2: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400),
      display1: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400),
      headline: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
      title: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      subhead: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
      body1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      subtitle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      //headline1: TextStyle(fontSize: 112.0, fontWeight: FontWeight.w100),
      //headline2: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w400),
      //headline3: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400),
      //headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400),
      //headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
      //headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      //subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      //subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      //bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      //bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
      button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
    ),
  );
}
