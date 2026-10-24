import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const primary = Color(0xFFD75A32);
  static const background = Color(0xFFFFF8F0);
  static const ink = Color(0xFF24352F);
  static const accent = Color(0xFFE8D9C5);
  static const pagePadding = 24.0;
  static const radius = 24.0;

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: 'PlusJakartaSans',
    colorScheme: ColorScheme.fromSeed(seedColor: primary).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: ink,
      secondaryContainer: accent,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: ink,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}
