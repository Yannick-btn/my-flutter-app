import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// costomisation of theme/text/color for the app
var appTheme = ThemeData(
  // import google font
  fontFamily: GoogleFonts.nunito().fontFamily,

  brightness: Brightness.dark,
  textTheme: const TextTheme(
    // can presstyle the font size, color, etc.
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 16),
    labelMedium: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
  ),
);
