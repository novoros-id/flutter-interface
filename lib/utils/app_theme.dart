import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.blue;
  static const Color backgroundColor = Colors.white;
  static const Color inputFillColor = Color(0xFFF5F8FB);
  static const Color textHintColor = Colors.grey;
  static const Color linkColor = Color(0xFF6B8CA8);
  static const Color linkActiveColor = Color(0xFF4A6FA5);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(secondary: primaryColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}