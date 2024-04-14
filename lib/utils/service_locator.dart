import 'package:get_it/get_it.dart';
import 'package:weather_app/services/core/geolocating/geolocating.dart';
import 'package:weather_app/services/core/geolocating/implementations/geolocating_impl.dart';
import 'package:weather_app/services/datasources/weather/implementation/weather_data_source_impl.dart';
import 'package:weather_app/services/datasources/weather/weather_data_source.dart';
import 'package:weather_app/services/repositories/weather/implementation/weather_repository_impl.dart';
import 'package:weather_app/services/repositories/weather/weather_repository.dart';

final GetIt serviceLocator = GetIt.instance;

void registerServices() {
  //independent services
  final Geolocating geolocating = GeolocatingImpl();

  // datasources
  final WeatherDataSource weatherDataSource = WeatherDataSourceImpl(geolocating: geolocating);

  //repositories
  final WeatherRepository weatherRepository = WeatherRepositoryImpl(weatherDataSource: weatherDataSource);

  // START REGISTRATION

  serviceLocator.registerSingleton<Geolocating>(geolocating);

  // datasources
  serviceLocator.registerSingleton<WeatherDataSource>(weatherDataSource);
  // repositories

  serviceLocator.registerSingleton<WeatherRepository>(weatherRepository);
}
