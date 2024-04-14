import 'package:weather_app/models/current_weather_result.dart';
import 'package:weather_app/models/forecast_weather_result.dart';

abstract class WeatherRepository {
   Future<CurrentWeatherResult> getCurrentWeather();
    Future<ForecastWeatherResult> get5DayForecast();
}
