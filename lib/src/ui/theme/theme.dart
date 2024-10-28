import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//beautiful color? Color(0xFF003459)
const primaryColor = Color(0xFF0D80F2);
const gradientColor = Color(0xFF006BFF);
const secondaryColor = Color.fromARGB(255, 59, 93, 196);
const thirdColor = Color.fromARGB(255, 166, 188, 255);

final lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
      surface: Color(0xFFF7FAFC),
      surfaceContainer: Color(0xFFE8EDF5),
      onSecondary: Color(0xFF4A739C)),
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
  fontFamily: GoogleFonts.getFont('Unbounded').fontFamily,
  useMaterial3: true,
);
final darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
      surface: Color(0xFF0F1A24),
      surfaceContainer: Color(0xFF21364A),
      onSecondary: Color(0xFF8FADCC)),
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
  fontFamily: GoogleFonts.getFont('Unbounded').fontFamily,
);
