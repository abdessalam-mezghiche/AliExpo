import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.grey[50],
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      // selectedItemColor: Colors.orange
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    appBarTheme: const AppBarTheme(
        // backwardsCompatibility: false,
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0));
ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: const Color.fromARGB(255, 018, 018, 018),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Color.fromARGB(179, 255, 255, 255)),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light)),
    textTheme: const TextTheme(
        bodyLarge:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white)));
