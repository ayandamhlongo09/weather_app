import 'dart:convert';

import 'package:weather_app/models/favorite_locations.dart';
import 'package:weather_app/services/datasources/favorites/local_storage_data_source.dart';
import 'package:weather_app/services/repositories/storage/local_storage_repository.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalStorageDataSource localStorageDataSource;

  LocalStorageRepositoryImpl({required this.localStorageDataSource});

  @override
  Future<List<FavoriteLocations>> getFavoriteLocations() async {
    final result = await localStorageDataSource.getFavoriteLocations();
    final List<dynamic> jsonList = json.decode(result ?? "");
    final List<FavoriteLocations> favoriteLocationsList = jsonList.map((json) => FavoriteLocations.fromJson(json)).toList();
    return favoriteLocationsList;
  }

  @override
  Future<void> saveFavoriteLocations(List<FavoriteLocations> list) async {
    final String jsonString = json.encode(list.map((location) => location.toJson()).toList());
    return localStorageDataSource.saveFavoriteLocations(jsonString);
  }
}
