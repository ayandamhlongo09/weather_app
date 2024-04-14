import 'package:weather_app/models/current_weather_result.dart';

abstract class WeatherRepository {
   Future<CurrentWeatherResult> getCurrentWeather();
}
