import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:weather_app/models/forecast_weather_result.dart';
import 'package:weather_app/models/location_coordinates.dart';
import 'package:weather_app/services/core/geolocating/geolocating.dart';
import 'package:weather_app/helpers/exceptions/network_exceptions.dart';
import 'package:weather_app/models/current_weather_result.dart';

import '../weather_data_source.dart';

class WeatherDataSourceImpl implements WeatherDataSource {
  final Duration timeout;
  final Geolocating geolocating;

  WeatherDataSourceImpl({this.timeout = const Duration(seconds: 30), required this.geolocating});

  @override
  Future<CurrentWeatherResult> getCurrentWeather() async {
    LocationCoordinates coordinates = await geolocating.getLatLongCordinates;
    var client = HttpClient();
    final url = Uri.parse('${GlobalConfiguration().getValue<String>('weatherApiBaseUrl')}weather').replace(queryParameters: {
      'lat': coordinates.latitude.toString(),
      'lon': coordinates.longitude.toString(),
      'appid': GlobalConfiguration().getValue<String>('weatherApiKey'),
    });

    try {
      HttpClientRequest request = await client.getUrl(url);
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        return CurrentWeatherResult.fromRawJson(responseBody);
      } else {
        throw ErrorResponseException('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ErrorResponseException('Error fetching data: $e');
    } finally {
      client.close();
    }
  }

  @override
  Future<ForecastWeatherResult> get5DayForecast() async {
    LocationCoordinates coordinates = await geolocating.getLatLongCordinates;

    var client = HttpClient();
    final url = Uri.parse('${GlobalConfiguration().getValue<String>('weatherApiBaseUrl')}forecast').replace(queryParameters: {
      'lat': coordinates.latitude.toString(),
      'lon': coordinates.longitude.toString(),
      'appid': GlobalConfiguration().getValue<String>('weatherApiKey'),
    });

    try {
      final request = await client.getUrl(url);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        print(responseBody);
        var forecastResult = ForecastWeatherResult.fromRawJson(responseBody);
        var filteredForecast = forecastResult.filterFirst3Hours();
        forecastResult.list = filteredForecast;
        return forecastResult;
      } else {
        print('Failed with status code: ${response.statusCode}');
        throw NetworkErrorException();
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw NetworkErrorException();
    } finally {
      client.close();
    }
  }
}
