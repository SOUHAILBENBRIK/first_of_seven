
import 'package:flutter/material.dart';

ThemeData myTheme(){
  return ThemeData(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white,),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.black),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black)

  );
}