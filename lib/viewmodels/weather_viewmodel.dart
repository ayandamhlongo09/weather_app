import 'package:flutter/material.dart';
import 'package:weather_app/helpers/exceptions/network_exceptions.dart';
import 'package:weather_app/models/current_weather_result.dart';
import 'package:weather_app/services/repositories/weather/weather_repository.dart';
import 'package:weather_app/utils/notifier_state.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repository;

  LoadingStatus _status = LoadingStatus.idle;
  CurrentWeatherResult? _currentWeatherResult;

  WeatherViewModel({
    required WeatherRepository repository,
  }) : _repository = repository {
    getCurrentWeather();
  }

  Future<void> getCurrentWeather() async {
    if (_currentWeatherResult != null) {
      _status = LoadingStatus.idle;
    } else {
      _status = LoadingStatus.busy;
    }
    try {
      _currentWeatherResult = await _repository.getCurrentWeather();
      _status = LoadingStatus.completed;
      notifyListeners();
    } on ErrorResponseException catch (_) {
      _status = LoadingStatus.failed;
      notifyListeners();
    } catch (error) {
      _status = LoadingStatus.failed;
      notifyListeners();
    }
  }

  void reset() {
    _currentWeatherResult = null;
    _status = LoadingStatus.idle;
  }

  LoadingStatus get status => _status;
  CurrentWeatherResult? get currentWeatherResult => _currentWeatherResult;
}
