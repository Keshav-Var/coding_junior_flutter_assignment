import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[200],
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black87),
    bodySmall: TextStyle(color: Colors.black54),
  ),
);

static final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey[900],
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    bodySmall: TextStyle(color: Colors.white60),
  ),
);

}
