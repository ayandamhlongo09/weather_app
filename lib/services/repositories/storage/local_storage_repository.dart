import 'package:weather_app/models/favorite_locations.dart';

abstract class LocalStorageRepository {
  Future<List<FavoriteLocations>> getFavoriteLocations();
  Future<void> saveFavoriteLocations(List<FavoriteLocations> list);
}
