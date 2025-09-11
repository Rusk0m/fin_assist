import 'package:flutter/material.dart';

const primaryColor = Color(0xFF4997CF);

final lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  focusColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFFEFF1F3),
  dividerTheme:  DividerThemeData(
    color:  Colors.grey.withOpacity(0.1),
  ),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: primaryColor,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  focusColor: primaryColor,
  scaffoldBackgroundColor: Colors.black54,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: primaryColor,
  ),
);

final textTheme = const TextTheme(
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600
  ),
  headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600
  ),
);
