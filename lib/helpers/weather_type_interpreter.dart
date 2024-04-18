import 'package:weather_app/utils/enums.dart';

WeatherTypes interpretWeatherType(String type) {
  var lowerCaseType = type.toLowerCase();
  if (lowerCaseType == "clear") lowerCaseType = "sunny";
  final interpretedType = lowerCaseType.endsWith('s') ? '${lowerCaseType.substring(0, lowerCaseType.length - 1)}y' : lowerCaseType;

  switch (interpretedType) {
    case 'sunny':
      return WeatherTypes.sunny;
    case 'cloudy':
      return WeatherTypes.cloudy;
    case 'rainy':
      return WeatherTypes.rainy;
    default:
      return WeatherTypes.sunny;
  }
}