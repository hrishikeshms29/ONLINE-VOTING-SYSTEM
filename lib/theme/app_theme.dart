import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.red),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        buttonColor: Colors.blue,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: Colors.grey.shade100,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        labelStyle: const TextStyle(color: Colors.blue),
        hintStyle: TextStyle(color: Colors.grey.shade600),
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black87),
        headline1: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
    ).copyWith(secondary: Colors.red),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    elevation: 0,
    titleTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 20,
    ),
    iconTheme: IconThemeData(
    color: Colors.white,
    ),
    ),
    buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
    ),
    buttonColor: Colors.blue,
    ),
    textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
    foregroundColor: Colors.blue,
    ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
    ),
    ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
    color: Colors.grey.shade900,
    shadowColor: Colors.grey.shade800,
    elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    ),
    ),
    inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      labelStyle: const TextStyle(color: Colors.blue),
      hintStyle: TextStyle(color: Colors.grey.shade500),
    ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white70),
        headline1: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
