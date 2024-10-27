import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//beautiful color? Color(0xFF003459)
const primaryColor = Color(0xFF4D4DFF);
const gradientColor = Color(0xFF006BFF);
const secondaryColor = Color.fromARGB(255, 59, 93, 196);
const thirdColor = Color.fromARGB(255, 166, 188, 255);

final lightTheme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    // prefixIcon: Icon(Icons.email),
    filled: true,
    fillColor: Color(0xFFE8EDF5),
    hintStyle: TextStyle(color: Color(0xFF4A739C)),
    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.transparent)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.transparent)),
  ),
  canvasColor: const Color(0xFFF7FAFC),
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
  inputDecorationTheme: const InputDecorationTheme(
    // prefixIcon: Icon(Icons.email),
    filled: true,
    fillColor: Color(0xFF21364A),
    hintStyle: TextStyle(color: Color(0xFF8FADCC)),
    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.transparent)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.transparent)),
  ),
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
