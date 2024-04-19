import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:weather_app/models/favorite_locations.dart';
import 'package:weather_app/models/place_details.dart';
import 'package:weather_app/helpers/exceptions.dart';
import 'package:weather_app/services/datasources/places/places_data_source.dart';

class PlacesDataSourceImpl implements PlacesDataSource {
  final Duration timeout;

  PlacesDataSourceImpl({
    this.timeout = const Duration(seconds: 30),
  });

  @override
  Future<PlaceDetails> getPlaceDetails(FavoriteLocations location) async {
    String base = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?";
    var client = HttpClient();
    final url = Uri.parse(base).replace(queryParameters: {
      'input': "${location.cityName},${location.countryCode}",
      'inputtype': "textquery",
      'fields': "photo,formatted_address,name,rating,opening_hours,geometry,icon,place_id,type",
      'key': GlobalConfiguration().getValue<String>('googlePlacesKey'),
    });

    try {
      HttpClientRequest request = await client.getUrl(url);
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        return PlaceDetails.fromRawJson(responseBody);
      } else {
        throw ErrorResponseException('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ErrorResponseException('Error fetching data: $e');
    } finally {
      client.close();
    }
  }
}
