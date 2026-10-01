import 'package:flutter/material.dart';

class NoirTheme {
  // Arka plan ve genel renkler
  static const Color background = Color(0xFF101216);
  static const Color surface = Color(0xFF181A20);
  static const Color surfaceLight = Color(0xFF222630);
  static const Color surfaceBorder = Color(0xFF353C4A);

  // Aksan ve Atmosferik Renkler
  static const Color amberWarm = Color(0xFFE5A65D);
  static const Color amberGlow = Color(0xFFFFBE76);
  static const Color coffeeBrown = Color(0xFF6F4E37);
  static const Color coffeeDark = Color(0xFF3E2723);
  static const Color milkCream = Color(0xFFFFF8E7);

  // Damga ve Karar Renkleri (Papers, Please Tarzı)
  static const Color stampGreen = Color(0xFF27AE60);
  static const Color stampRed = Color(0xFFC0392B);
  static const Color stampWarning = Color(0xFFD35400);
  static const Color uvPurple = Color(0xFF9B59B6);
  static const Color uvGlow = Color(0xFF8E44AD);

  // Gazete ve Kağıt Renkleri
  static const Color paperBg = Color(0xFFE8DFC8);
  static const Color paperBorder = Color(0xFFC4B89B);
  static const Color paperInk = Color(0xFF22201C);
  static const Color paperFadedInk = Color(0xFF5A554A);

  // Yazı Stilleri (Courier / Monospace tabanlı retro daktilo hissi)
  static const TextStyle typewriterHeading = TextStyle(
    fontFamily: 'Courier',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: amberWarm,
  );

  static const TextStyle typewriterSubheading = TextStyle(
    fontFamily: 'Courier',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
    color: Colors.white70,
  );

  static const TextStyle typewriterBody = TextStyle(
    fontFamily: 'Courier',
    fontSize: 14,
    letterSpacing: 0.8,
    color: Colors.white,
    height: 1.4,
  );

  static const TextStyle paperText = TextStyle(
    fontFamily: 'Courier',
    fontSize: 13,
    letterSpacing: 0.5,
    color: paperInk,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle stampText = TextStyle(
    fontFamily: 'Courier',
    fontSize: 20,
    fontWeight: FontWeight.w900,
    letterSpacing: 3.0,
  );
}
