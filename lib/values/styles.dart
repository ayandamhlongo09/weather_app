import 'package:flutter/material.dart';
import 'package:weather_app/values/colors.dart';

class MyTextStyles {
  static TextStyle? primaryText1({
    Color color = AppColors.white,
    FontWeight fontWeight = FontWeight.w700,
    double fontSize = 14,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }
}

class CustomTheme {
  CustomTheme();

  TextStyle get getPrimaryText => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );

  TextStyle get getSecondaryText => const TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 20,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );

  TextStyle get getCurrentWeatherText => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 80,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );
}
