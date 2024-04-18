import 'package:weather_app/services/core/storage/local_storage.dart';
import 'package:weather_app/services/datasources/favorites/local_storage_data_source.dart';

class LocalStorageDataSourceImpl extends LocalStorageDataSource {
  static const String _keyFavoriteLocations = 'favorite_locations';

  final LocalStorage localStorage;
  LocalStorageDataSourceImpl({required this.localStorage});

  @override
  Future<String?> getFavoriteLocations() async {
    return await localStorage.get<String?>(_keyFavoriteLocations);
  }

  @override
  Future<void> saveFavoriteLocations(String jsonString) async {
    return await localStorage.put<String?>(_keyFavoriteLocations, jsonString);
  }
}
