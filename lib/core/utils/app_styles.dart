import 'package:flutter/material.dart';

abstract class AppStyles {
  static const String _headingFontFamily = 'Poppins';
  static const String _bodyFontFamily = 'Inter';

  static TextStyle heading1Bold32(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 32),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: 0,
  );

  static TextStyle heading1SemiBold32(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 32),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0,
  );

  static TextStyle heading1Regular32(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 32),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.25,
    letterSpacing: 0,
  );

  static TextStyle heading2Bold24(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle heading2SemiBold24(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle heading2Regular24(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle heading3Medium22(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 22),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  static TextStyle heading3Bold18(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 18),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle heading3SemiBold18(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 18),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle heading3Regular18(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 18),
    fontFamily: _headingFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle button1SemiBold16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle button2SemiBold14(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle body1Medium16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w500,
    height: 1.75,
    letterSpacing: 0,
  );

  static TextStyle body1SemiBold16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w600,
    height: 1.75,
    letterSpacing: 0,
  );

  static TextStyle body1Regular16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.75,
    letterSpacing: 0,
  );

  static TextStyle body2Medium14(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle body2Regular14(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle captionBold12(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 12),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle captionSemiBold12(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 12),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle captionRegular12(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 12),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle overlineSemiBold10(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 10),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle overlineRegular10(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 10),
    fontFamily: _bodyFontFamily,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  return width / 550;
}
