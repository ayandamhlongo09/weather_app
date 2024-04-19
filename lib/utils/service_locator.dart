import 'package:get_it/get_it.dart';
import 'package:weather_app/services/core/geolocating/geolocating.dart';
import 'package:weather_app/services/core/geolocating/geolocating_impl.dart';
import 'package:weather_app/services/core/storage/local_storage.dart';
import 'package:weather_app/services/core/storage/local_storage_impl.dart';
import 'package:weather_app/services/datasources/places/implementation/places_data_source_impl.dart';
import 'package:weather_app/services/datasources/places/places_data_source.dart';
import 'package:weather_app/services/datasources/storage/implementations/local_storage_data_source_impl.dart';
import 'package:weather_app/services/datasources/storage/local_storage_data_source.dart';
import 'package:weather_app/services/datasources/weather/implementation/weather_data_source_impl.dart';
import 'package:weather_app/services/datasources/weather/weather_data_source.dart';
import 'package:weather_app/services/repositories/places/implementation/places_repository_impl.dart';
import 'package:weather_app/services/repositories/places/places_repository.dart';
import 'package:weather_app/services/repositories/storage/implementations/local_storage_repository_impl.dart';
import 'package:weather_app/services/repositories/storage/local_storage_repository.dart';
import 'package:weather_app/services/repositories/weather/implementation/weather_repository_impl.dart';
import 'package:weather_app/services/repositories/weather/weather_repository.dart';

final GetIt serviceLocator = GetIt.instance;

void registerServices() {
  //independent services
  final Geolocating geolocating = GeolocatingImpl();
  final LocalStorage localStorage = LocalStorageImpl();

  // datasources
  final WeatherDataSource weatherDataSource = WeatherDataSourceImpl(geolocating: geolocating);
  final LocalStorageDataSource localStorageDataSource = LocalStorageDataSourceImpl(localStorage: localStorage);
  final PlacesDataSource placesDataSource = PlacesDataSourceImpl();

  //repositories
  final WeatherRepository weatherRepository = WeatherRepositoryImpl(weatherDataSource: weatherDataSource);
  final LocalStorageRepository localStorageRepository = LocalStorageRepositoryImpl(localStorageDataSource: localStorageDataSource);
  final PlacesRepository placesRepository = PlacesRepositoryImpl(placesDataSource: placesDataSource);

  // START REGISTRATION

  // serviceLocator.registerSingleton<Geolocating>(geolocating);

  // datasources
  serviceLocator.registerSingleton<WeatherDataSource>(weatherDataSource);
  serviceLocator.registerSingleton<LocalStorageDataSource>(localStorageDataSource);
  serviceLocator.registerSingleton<PlacesDataSource>(placesDataSource);
  // repositories

  serviceLocator.registerSingleton<WeatherRepository>(weatherRepository);
  serviceLocator.registerSingleton<LocalStorageRepository>(localStorageRepository);
  serviceLocator.registerSingleton<PlacesRepository>(placesRepository);
}
