import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather_app/services/repositories/places/places_repository.dart';
import 'package:weather_app/services/repositories/storage/local_storage_repository.dart';
import 'package:weather_app/services/repositories/weather/weather_repository.dart';
import 'package:weather_app/utils/service_locator.dart';
import 'package:weather_app/viewmodels/favorites_viewmodel.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';

List<SingleChildWidget> appProviders = [
  ...viewModelProviders,
];

List<SingleChildWidget> viewModelProviders = [
  ChangeNotifierProvider(
    create: (context) => WeatherViewModel(
      repository: serviceLocator<WeatherRepository>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => FavoritesViewModel(
      localStorageRepository: serviceLocator<LocalStorageRepository>(),
      placesRepository: serviceLocator<PlacesRepository>(),
    ),
  ),
];
