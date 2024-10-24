import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//beautiful color? Color(0xFF003459)
const primaryColor = Color(0xFF4D4DFF);
const gradientColor = Color(0xFF006BFF);
const secondaryColor = Color.fromARGB(255, 59, 93, 196);
const thirdColor = Color.fromARGB(255, 166, 188, 255);

final lightTheme = ThemeData(
  indicatorColor: Colors.red,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      )),
  fontFamily: GoogleFonts.getFont('Unbounded').fontFamily,
  useMaterial3: true,
);
final darkTheme = ThemeData(
  indicatorColor: Colors.red,
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: primaryColor,
  canvasColor: Colors.black,
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      )),
  fontFamily: GoogleFonts.getFont('Unbounded').fontFamily,
);
