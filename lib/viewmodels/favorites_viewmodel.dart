import 'package:flutter/material.dart';
import 'package:weather_app/helpers/exceptions/network_exceptions.dart';
import 'package:weather_app/models/favorite_locations.dart';
import 'package:weather_app/models/place_details.dart';
import 'package:weather_app/services/repositories/places/places_repository.dart';
import 'package:weather_app/services/repositories/storage/local_storage_repository.dart';
import 'package:weather_app/utils/notifier_state.dart';

class FavoritesViewModel extends ChangeNotifier {
  final LocalStorageRepository _localStorageRepository;
  final PlacesRepository _placesRepository;

  LoadingStatus _status = LoadingStatus.idle;

  List<FavoriteLocations> _favoriteLocations = [];
  PlaceDetails? _details;

  FavoritesViewModel({required LocalStorageRepository localStorageRepository, required PlacesRepository placesRepository})
      : _localStorageRepository = localStorageRepository,
        _placesRepository = placesRepository {
    getFavoriteLocations();
  }

  bool addNewFavoriteLocation({required FavoriteLocations location}) {
    _status = LoadingStatus.busy;

    try {
      if (!_favoriteLocations.any((favoriteLocation) => favoriteLocation.cityName == location.cityName)) {
        _favoriteLocations.add(location);
        _localStorageRepository.saveFavoriteLocations(_favoriteLocations);
      }
      notifyListeners();

      getFavoriteLocations;
      _status = LoadingStatus.completed;
      return true;
    } on ErrorResponseException catch (_) {
      return false;
    } catch (error) {
      return false;
    }
  }

  bool removeFavoriteLocations({required FavoriteLocations location}) {
    _status = LoadingStatus.busy;

    try {
      _favoriteLocations.remove(location);
      _localStorageRepository.saveFavoriteLocations(_favoriteLocations);

      notifyListeners();
      getFavoriteLocations;
      _status = LoadingStatus.completed;
      return true;
    } on ErrorResponseException catch (_) {
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> getFavoriteLocations() async {
    try {
      _status = LoadingStatus.busy;
      notifyListeners();
      _favoriteLocations = await _localStorageRepository.getFavoriteLocations();
      _status = LoadingStatus.completed;

      notifyListeners();
    } on ErrorResponseException catch (_) {}
  }

  bool isLocationFavorited(FavoriteLocations location) {
    for (var item in _favoriteLocations) {
      if (item.cityName == location.cityName && item.countryCode == location.countryCode) {
        return true;
      }
    }
    return false;
  }

  Future<void> getPlaceDetails(FavoriteLocations location) async {
    try {
      _status = LoadingStatus.busy;
      // notifyListeners();
      _details = await _placesRepository.getPlaceDetails(location);
      _status = LoadingStatus.completed;
    } on ErrorResponseException catch (_) {}
  }

  void reset() {
    _favoriteLocations = [];
    _status = LoadingStatus.idle;
    _details = null;
    notifyListeners();
  }

  LoadingStatus get status => _status;
  List<FavoriteLocations> get favoriteLocations => _favoriteLocations;
  PlaceDetails? get details => _details;
  // set setDetails(LoadingStatus value) {
  //   _status = value;
  // }
}
