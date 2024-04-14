import 'package:weather_app/models/current_weather_result.dart';
import 'package:weather_app/models/forecast_weather_result.dart';
import 'package:weather_app/services/datasources/weather/weather_data_source.dart';

import '../weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource weatherDataSource;

  WeatherRepositoryImpl({
    required this.weatherDataSource,
  });

  @override
  Future<CurrentWeatherResult> getCurrentWeather() {
    return weatherDataSource.getCurrentWeather();
  }

  @override
  Future<ForecastWeatherResult> get5DayForecast() {
    return weatherDataSource.get5DayForecast();
  }
}
