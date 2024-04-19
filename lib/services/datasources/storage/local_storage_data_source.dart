abstract class LocalStorageDataSource {
  Future<String?> getFavoriteLocations();
  Future<void> saveFavoriteLocations(String jsonString);
}
