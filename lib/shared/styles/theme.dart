import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  fontFamily: 'NunitoSans',
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.deepPurple,
    backgroundColor: Colors.white,
    elevation: 15.0,
    selectedLabelStyle: TextStyle(color: Colors.deepPurple),
    selectedIconTheme: IconThemeData(
      color: Colors.deepPurple,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple),
    ),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
    labelStyle: TextStyle(
      color: Colors.deepPurple,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 2.0,
    iconTheme: IconThemeData(
      color: Colors.deepPurple,
    ),
  ),
);
