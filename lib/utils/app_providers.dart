import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather_app/services/repositories/weather/weather_repository.dart';
import 'package:weather_app/utils/service_locator.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';

List<SingleChildWidget> appProviders = [
  ...viewModelProviders,
];

List<SingleChildWidget> viewModelProviders = [
  ChangeNotifierProvider(
    create: (context) => WeatherViewModel(
      repository: serviceLocator<WeatherRepository>(),
    ),
  )
];
