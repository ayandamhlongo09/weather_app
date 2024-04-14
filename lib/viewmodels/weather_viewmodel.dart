import 'package:flutter/material.dart';
import 'package:weather_app/helpers/exceptions/network_exceptions.dart';
import 'package:weather_app/models/current_weather_result.dart';
import 'package:weather_app/models/forecast_weather_result.dart';
import 'package:weather_app/services/repositories/weather/weather_repository.dart';
import 'package:weather_app/utils/notifier_state.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repository;

  LoadingStatus _status = LoadingStatus.idle;
  CurrentWeatherResult? _currentWeatherResult;
  ForecastWeatherResult? _forecastWeatherResult;

  bool _currentWeatherCompleted = false;
  bool _forecastCompleted = false;

  WeatherViewModel({
    required WeatherRepository repository,
  }) : _repository = repository {
    init();
  }
  
  Future<void> init() async {
    await getCurrentWeather();
    await get5DayForecast();
  }

  Future<void> getCurrentWeather() async {
    if (_currentWeatherResult != null) {
      _status = LoadingStatus.idle;
    } else {
      _status = LoadingStatus.busy;
    }
    try {
      _currentWeatherResult = await _repository.getCurrentWeather();
      _currentWeatherCompleted = true;
      _updateStatus();
    } on ErrorResponseException catch (_) {
      _status = LoadingStatus.failed;
      notifyListeners();
    } catch (error) {
      _status = LoadingStatus.failed;
      notifyListeners();
    }
  }

  Future<void> get5DayForecast() async {
    if (_forecastWeatherResult != null) {
      _status = LoadingStatus.idle;
    } else {
      _status = LoadingStatus.busy;
    }
    try {
      _forecastWeatherResult = await _repository.get5DayForecast();
      _forecastCompleted = true;

      _updateStatus();
    } on NetworkErrorException catch (_) {
      _status = LoadingStatus.failed;
      notifyListeners();
    } catch (error) {
      _status = LoadingStatus.failed;
      notifyListeners();
    }
  }

  void _updateStatus() {
    if (_currentWeatherCompleted && _forecastCompleted) {
      _status = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void reset() {
    _currentWeatherResult = null;
    _forecastWeatherResult = null;
    _status = LoadingStatus.idle;
    _currentWeatherCompleted = false;
    _forecastCompleted = false;
    notifyListeners();
  }

  LoadingStatus get status => _status;
  CurrentWeatherResult? get currentWeatherResult => _currentWeatherResult;
  ForecastWeatherResult? get forecastWeatherResult => _forecastWeatherResult;
}
