import 'package:flutter/material.dart';

class AppTheme {
  static get defaultTheme => ThemeData(
        splashColor: const Color(0xFFFFFFFF),
        primaryColor: const Color(0xFF11159A),
        cardColor: const Color(0xFFD8D8D8),
        secondaryHeaderColor: const Color(0xFF000000),
        focusColor: const Color(0xFFF44336),
        highlightColor: const Color(0xFFFFBE00),
        primaryTextTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFF11159A),
            fontSize: 50,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF11159A),
            fontSize: 30,
          ),
          bodySmall: TextStyle(
            color: Color(0xFF11159A),
            fontSize: 17,
          ),
        ),
      );
}
