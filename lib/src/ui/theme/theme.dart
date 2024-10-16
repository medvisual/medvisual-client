import 'package:flutter/material.dart';

class AppTheme {
  static final colors = [
    const Color.fromARGB(255, 77, 77, 255),
    const Color.fromARGB(255, 59, 93, 196),
    const Color.fromARGB(255, 166, 188, 255),
  ];

  static final lightTheme = ThemeData(
    primaryColor: colors.first,
    textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
        )),
    fontFamily: 'Unbounded',
  );
  static final darkTheme = ThemeData();
}
