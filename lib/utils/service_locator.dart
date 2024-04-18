import 'package:get_it/get_it.dart';
import 'package:weather_app/services/core/geolocating/geolocating.dart';
import 'package:weather_app/services/core/geolocating/geolocating_impl.dart';
import 'package:weather_app/services/core/storage/local_storage.dart';
import 'package:weather_app/services/core/storage/local_storage_impl.dart';
import 'package:weather_app/services/datasources/favorites/implementations/local_storage_data_source_impl.dart';
import 'package:weather_app/services/datasources/favorites/local_storage_data_source.dart';
import 'package:weather_app/services/datasources/weather/implementation/weather_data_source_impl.dart';
import 'package:weather_app/services/datasources/weather/weather_data_source.dart';
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

  //repositories
  final WeatherRepository weatherRepository = WeatherRepositoryImpl(weatherDataSource: weatherDataSource);
  final LocalStorageRepository localStorageRepository = LocalStorageRepositoryImpl(localStorageDataSource: localStorageDataSource);

  // START REGISTRATION

  // serviceLocator.registerSingleton<Geolocating>(geolocating);

  // datasources
  serviceLocator.registerSingleton<WeatherDataSource>(weatherDataSource);
  serviceLocator.registerSingleton<LocalStorageDataSource>(localStorageDataSource);
  // repositories

  serviceLocator.registerSingleton<WeatherRepository>(weatherRepository);
  serviceLocator.registerSingleton<LocalStorageRepository>(localStorageRepository);
}
