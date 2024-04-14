import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:weather_app/models/forecast_weather_result.dart';
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
    Position position = await geolocating.getCurrentLocation;

    var client = HttpClient();
    final url = Uri.parse('${GlobalConfiguration().getValue<String>('weatherApiBaseUrl')}weather').replace(queryParameters: {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
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
    Position position = await geolocating.getCurrentLocation;
    var client = HttpClient();
    final url = Uri.parse('${GlobalConfiguration().getValue<String>('weatherApiBaseUrl')}forecast').replace(queryParameters: {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
      'appid': GlobalConfiguration().getValue<String>('weatherApiKey'),
    });

    try {
      final request = await client.getUrl(url);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        print(responseBody);
        // Parse the response into ForecasttWeatherResult
        var forecastResult = ForecastWeatherResult.fromRawJson(responseBody);
        // Filter the forecast list to get only the first 3 hours for each day
        var filteredForecast = forecastResult.filterFirst3Hours();
        // Update the forecast list in the result object
        forecastResult.list = filteredForecast;
        return forecastResult;
      } else {
        // Handle error response
        print('Failed with status code: ${response.statusCode}');
        throw NetworkErrorException();
      }
    } catch (e) {
      // Handle network errors
      print('Error fetching data: $e');
      throw NetworkErrorException();
    } finally {
      client.close();
    }
  }
}
