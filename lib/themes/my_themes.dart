import 'package:flutter/material.dart';

enum MyThemeKeys { Theme1, Theme2, Theme3, Theme4, Theme5, Theme6 }

class MyThemes {
  static final ThemeData theme1 = ThemeData(
    primaryColor: Color(0xFF739bF3),
    accentColor: Color(0xFF449BC4),
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFF739bF3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: 'Arvo',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Arvo',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      body2: TextStyle(
          fontSize: 16.0, fontFamily: 'Arvo', fontWeight: FontWeight.bold),
    ),
  );

  static final theme2 = ThemeData(
    primaryColor: Color(0xFF00E1D3),
    accentColor: Color(0xFF00B4D5),
//    primaryColor: Color(0xff00adb5),
//    accentColor: Colors.cyanAccent,
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFF00E1D3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: 'Arvo',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Arvo',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      body2: TextStyle(
          fontSize: 16.0, fontFamily: 'Arvo', fontWeight: FontWeight.bold),
    ),
  );

  static final theme3 = ThemeData(
    primaryColor: Color(0xFF65D5A3),
    accentColor: Color(0xFF3B9CA7),
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFF65D5A3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: 'Arvo',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Arvo',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      body2: TextStyle(
          fontSize: 16.0, fontFamily: 'Arvo', fontWeight: FontWeight.bold),
    ),
  );

  static final theme4 = ThemeData(
    primaryColor: Color(0xFFFC747E),
    accentColor: Color(0xFFF666A3),
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFFFC747E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: 'Arvo',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Arvo',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      body2: TextStyle(
          fontSize: 16.0, fontFamily: 'Arvo', fontWeight: FontWeight.bold),
    ),
  );

  static final theme5 = ThemeData(
    primaryColor: Color(0xFFFEC6E3),
    accentColor: Color(0xFFFF9B9D),
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFFFEC6E3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: 'Arvo',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Arvo',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      body2: TextStyle(
          fontSize: 16.0, fontFamily: 'Arvo', fontWeight: FontWeight.bold),
    ),
  );

  static final theme6 = ThemeData(
    primaryColor: Color(0xFF858AE5),
    accentColor: Color(0xFF786FC0),
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFF858AE5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: 'Arvo',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Arvo',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      body2: TextStyle(
          fontSize: 16.0, fontFamily: 'Arvo', fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.Theme1:
        return theme1;
      case MyThemeKeys.Theme2:
        return theme2;
      case MyThemeKeys.Theme3:
        return theme3;
      case MyThemeKeys.Theme4:
        return theme4;
      case MyThemeKeys.Theme5:
        return theme5;
      case MyThemeKeys.Theme6:
        return theme6;

      default:
        return theme1;
    }
  }
}
