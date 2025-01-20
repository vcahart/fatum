import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';

/* -- Light & Dark Text Themes -- */
class TTextTheme {
  TTextTheme._(); //To avoid creating instances

  /* -- Light Text Theme -- */
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.playfairDisplay(fontSize: 28.0, fontWeight: FontWeight.bold, color: tDarkColor),
    displayMedium: GoogleFonts.playfairDisplay(fontSize: 24.0, fontWeight: FontWeight.w700, color: tDarkColor),
    displaySmall: GoogleFonts.playfairDisplay(fontSize: 22.0, fontWeight: FontWeight.w800, color: tDarkColor),
    headlineMedium: GoogleFonts.sourceSans3(fontSize: 18.0, fontWeight: FontWeight.w600, color: tDarkColor),
    headlineSmall: GoogleFonts.sourceSans3(fontSize: 18.0, fontWeight: FontWeight.normal, color: tDarkColor),
    titleLarge: GoogleFonts.sourceSans3(fontSize: 14.0, fontWeight: FontWeight.w600, color: tDarkColor),
    bodyLarge: GoogleFonts.sourceSans3(fontSize: 14.0, color: tDarkColor),
    bodyMedium: GoogleFonts.sourceSans3(fontSize: 14.0, color: tDarkColor.withOpacity(0.8)),
  );

  /* -- Dark Text Theme -- */
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(fontSize: 28.0, fontWeight: FontWeight.bold, color: tWhiteColor),
    displayMedium: GoogleFonts.inter(fontSize: 24.0, fontWeight: FontWeight.w700, color: tWhiteColor),
    displaySmall: GoogleFonts.inter(fontSize: 24.0, fontWeight: FontWeight.normal, color: tWhiteColor),
    headlineMedium: GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    headlineSmall: GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.normal, color: tWhiteColor),
    titleLarge: GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    bodyLarge: GoogleFonts.inter(fontSize: 14.0, color: tWhiteColor),
    bodyMedium: GoogleFonts.inter(fontSize: 14.0, color: tWhiteColor.withOpacity(0.8)),
  );
}
