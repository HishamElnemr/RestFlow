import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF185FA5);
  static const Color primaryLight = Color(0xFF3B7DD8);
  static const Color primaryOpacity20 = Color(0x33185FA5);

  static const Color electricBlue = Color(0xFF2B7FFF);

  static const Color purple = Color(0xFF9810FA);
  static const Color purpleDeep = Color(0xFF8200DB);
  static const Color purpleLight = Color(0xFFE9D4FF);
  static const Color purpleSoft = Color(0xFFFAF5FF);
  static const Color purpleAccent = Color(0xFFAD46FF);
  static const Color purpleDeepAccent = Color(0xFF59168B);
  static const Color purpleLavenderLight = Color(0xFFF3E8FF);

  static const Color oliveGreen = Color(0xFF639922);
  static const Color oliveGreenOpacity20 = Color(0x33639922);
  static const Color oliveGreenLight = Color(0xFFEAF3DE);
  static const Color forestGreen = Color(0xFF3B6D11);
  static const Color successBg = Color(0xFFF0FDF4);
  static const Color successBright = Color(0xFF00C950);

  static const Color amber = Color(0xFFBA7517);
  static const Color amberOpacity20 = Color(0x33BA7517);
  static const Color warningBg = Color(0xFFFFFBEB);
  static const Color orange = Color(0xFFEF9F27);
  static const Color darkOrange = Color(0xFF854F0B);
  static const Color brightOrange = Color(0xFFFF6900);

  static const Color error = Color(0xFFE24B4A);
  static const Color darkRed = Color(0xFFA32D2D);
  static const Color errorBg = Color(0xFFFCEBEB);

  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteOpacity80 = Color(0xCCFFFFFF);
  static const Color whiteOpacity20 = Color(0x33FFFFFF);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFF3F4F6);
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color warmGray = Color(0xFFE0DDD6);
  static const Color ivory = Color(0xFFF1EFE8);
  static const Color cream = Color(0xFFFAEEDA);
  static const Color mutedGray = Color(0xFF5F5E5A);

  static const Color darkNavy = Color(0xFF1A1A2E);
  static const Color darkNavyOpacity50 = Color(0x801A1A2E);
  static const Color darkNavyOpacity80 = Color(0xCC1A1A2E);

  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color googleYellow = Color(0xFFFBBC05);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF185FA5),
      Color(0xFF1B61A9),
      Color(0xFF1E63AC),
      Color(0xFF2065B0),
      Color(0xFF2367B3),
      Color(0xFF256AB7),
      Color(0xFF286CBB),
      Color(0xFF2A6EBE),
      Color(0xFF2D70C2),
      Color(0xFF2F72C5),
      Color(0xFF3274C9),
      Color(0xFF3476CD),
      Color(0xFF3679D1),
      Color(0xFF397BD4),
      Color(0xFF3B7DD8),
    ],
    stops: [
      0.0,
      0.0714,
      0.1429,
      0.2143,
      0.2857,
      0.3571,
      0.4286,
      0.5,
      0.5714,
      0.6429,
      0.7143,
      0.7857,
      0.8571,
      0.9286,
      1.0,
    ],
  );

  static const LinearGradient electricBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2B7FFF),
      Color(0xFF155DFC),
    ],
  );

  static const LinearGradient purpleHorizontalGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF9810FA),
      Color(0xFFAD46FF),
    ],
  );

  static const LinearGradient purpleDiagonalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFAD46FF),
      Color(0xFF9810FA),
    ],
  );

  static const LinearGradient skyBlueSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEFF6FF),
      Color(0x80DBEAFE),
    ],
  );

  static const LinearGradient successSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF0FDF4),
      Color(0x80DCFCE7),
    ],
  );

  static const LinearGradient purpleSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFAF5FF),
      Color(0x80F3E8FF),
    ],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6900),
      Color(0xFFF54900),
    ],
  );

  static const LinearGradient orangeSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF7ED),
      Color(0x80FFEDD4),
    ],
  );
}
