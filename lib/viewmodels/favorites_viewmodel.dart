import 'package:flutter/material.dart';
import 'package:weather_app/helpers/exceptions/network_exceptions.dart';
import 'package:weather_app/models/favorite_locations.dart';
import 'package:weather_app/services/repositories/storage/local_storage_repository.dart';
import 'package:weather_app/utils/notifier_state.dart';

class FavoritesViewModel extends ChangeNotifier {
  final LocalStorageRepository _repository;

  LoadingStatus _status = LoadingStatus.idle;

  List<FavoriteLocations> _favoriteLocations = [];

  FavoritesViewModel({
    required LocalStorageRepository repository,
  }) : _repository = repository {
    getFavoriteLocations();
  }

  bool addNewLocation({required FavoriteLocations location}) {
    _status = LoadingStatus.busy;

    try {
      if (!_favoriteLocations.any((favoriteLocation) => favoriteLocation.cityName == location.cityName)) {
        _favoriteLocations.add(location);
        _repository.saveFavoriteLocations(_favoriteLocations);
      }
      // notifyListeners();
      return true;
    } on ErrorResponseException catch (_) {
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> getFavoriteLocations() async {
    try {
      _favoriteLocations = await _repository.getFavoriteLocations();
      _status = LoadingStatus.completed;

      notifyListeners();
    } on ErrorResponseException catch (_) {}
  }

  void reset() {
    notifyListeners();
  }

  LoadingStatus get status => _status;
  List<FavoriteLocations> get favoriteLocations => _favoriteLocations;
}
