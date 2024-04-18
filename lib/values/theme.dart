import 'package:flutter/material.dart';
import 'package:weather_app/values/colors.dart';
import 'package:weather_app/values/images.dart';

class WeatherTheme {
  final String name;
  final String sunnyImage;
  final String cloudyImage;
  final String rainyImage;

  WeatherTheme({
    required this.name,
    required this.sunnyImage,
    required this.cloudyImage,
    required this.rainyImage,
  });
}

List<WeatherTheme> themes = [
  WeatherTheme(
    name: 'Forest',
    sunnyImage: AppImages.forestSunny,
    cloudyImage: AppImages.forestCloudy,
    rainyImage: AppImages.forestRainy,
  ),
  WeatherTheme(
    name: 'Sea',
    sunnyImage: AppImages.seaSunny,
    cloudyImage: AppImages.seaCloudy,
    rainyImage: AppImages.seaRainy,
  ),
];

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
