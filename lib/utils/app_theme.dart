import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF13A4EC);
  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color backgroundDark = Color(0xFF101C22);
  
  static const Color textLight = Color(0xFF0F172A); // slate-900
  static const Color textDark = Color(0xFFF1F5F9); // slate-100
  static const Color textMutedLight = Color(0xFF64748B); // slate-500
  static const Color textMutedDark = Color(0xFF94A3B8); // slate-400

  // Secondary Colors
  static const Color danger = Color(0xFFEF4444); // red-500
  static const Color success = Color(0xFF10B981); // emerald-500
  static const Color warning = Color(0xFFF97316); // orange-500

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        error: danger,
        surface: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: textLight,
        displayColor: textLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: textLight),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFF1F5F9), width: 1), // slate-100
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        error: danger,
        surface: Color(0xFF1E293B), // slate-800
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: textDark,
        displayColor: textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B), // slate-800
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF334155), width: 1), // slate-700
        ),
      ),
    );
  }
}
