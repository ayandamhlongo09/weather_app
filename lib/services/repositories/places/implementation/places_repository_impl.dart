import 'dart:convert';
import 'dart:io';

import 'package:weather_app/models/favorite_locations.dart';
import 'package:weather_app/models/place_details.dart';
import 'package:weather_app/services/datasources/places/places_data_source.dart';
import 'package:weather_app/services/repositories/places/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesDataSource placesDataSource;

  PlacesRepositoryImpl({required this.placesDataSource});

  @override
  Future<PlaceDetails> getPlaceDetails(FavoriteLocations location) async {
    return placesDataSource.getPlaceDetails(location);
  }
}
