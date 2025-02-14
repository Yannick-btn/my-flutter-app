import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// costomisation of theme/text/color for the app
var appTheme = ThemeData(
  // import google font
  fontFamily: GoogleFonts.nunito().fontFamily,
  //brightness: Brightness.dark,
  textTheme: const TextTheme(
    // can presstyle the font size, color, etc.
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 16),
    labelMedium: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF0EBD60),
    secondary: Color(0xFFCAD1C9),
    tertiary: Color(0xFF184C34),
    onSecondary: quaternary,
  ),
  scaffoldBackgroundColor: Color(0xFFEFF4ED),
);
const Color quaternary = Color(0xFFEFF4ED);
