import 'package:weather_app/models/current_weather_result.dart';

abstract class WeatherDataSource {
Future<CurrentWeatherResult> getCurrentWeather();
}
