import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/degrees_celsius_value.dart';
import 'package:weather_app/components/loading_widget.dart';
import 'package:weather_app/components/no_data_widget.dart';
import 'package:weather_app/helpers/string_extension.dart';
import 'package:weather_app/helpers/weather_type_interpreter.dart';
import 'package:weather_app/utils/enums.dart';
import 'package:weather_app/utils/notifier_state.dart';
import 'package:weather_app/values/colors.dart';
import 'package:weather_app/values/icons.dart';
import 'package:weather_app/values/theme.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CustomTheme theme = CustomTheme();
  WeatherTheme selectedTheme = themes.first;

  Widget getBackGroundImage({
    required WeatherTheme selectedTheme,
    required WeatherTypes weatherType,
  }) {
    ImageProvider weatherImage;
    switch (weatherType) {
      case WeatherTypes.sunny:
        weatherImage = AssetImage(selectedTheme.sunnyImage);
        break;
      case WeatherTypes.cloudy:
        weatherImage = AssetImage(selectedTheme.cloudyImage);
        break;
      case WeatherTypes.rainy:
        weatherImage = AssetImage(selectedTheme.rainyImage);
        break;
      default:
        weatherImage = AssetImage(selectedTheme.sunnyImage);
        break;
    }

    return Image(
      width: double.infinity,
      image: weatherImage,
      fit: BoxFit.fitWidth,
    );
  }

  Color getScaffoldBackgroundColor({
    required WeatherTheme selectedTheme,
    required WeatherTypes weatherType,
  }) {
    switch (weatherType) {
      case WeatherTypes.sunny:
        if (selectedTheme.name == 'Forest') {
          return AppColors.sunny;
        } else {
          return AppColors.blue;
        }
      case WeatherTypes.cloudy:
        return AppColors.cloudy;
      case WeatherTypes.rainy:
        return AppColors.rainy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherViewModel>(builder: (BuildContext context, WeatherViewModel viewModel, _) {
        return ConditionalSwitch.single<LoadingStatus>(
          context: context,
          valueBuilder: (BuildContext context) => viewModel.status,
          caseBuilders: {
            LoadingStatus.busy: (BuildContext context) => const LoadingWidget(),
            LoadingStatus.failed: (BuildContext context) => const NoDataWidget(message: 'No weather data available'),
            LoadingStatus.idle: (BuildContext context) => const LoadingWidget(),
            LoadingStatus.completed: (BuildContext context) => weatherView(viewModel: viewModel),
          },
          fallbackBuilder: (BuildContext context) => const SizedBox(),
        );
      }),
    );
  }

  Widget weatherView({required WeatherViewModel viewModel}) {
    return Container(
      color: getScaffoldBackgroundColor(
          selectedTheme: selectedTheme, weatherType: interpretWeatherType(viewModel.currentWeatherResult!.weather[0].main)),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        getBackGroundImage(
                            selectedTheme: selectedTheme, weatherType: interpretWeatherType(viewModel.currentWeatherResult!.weather[0].main)),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 8,
                          left: MediaQuery.of(context).size.width / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DegreesCelsiusValue(
                                value: viewModel.currentWeatherResult!.main.temp,
                                textStyle: theme.getCurrentWeatherText,
                              ),
                              Text(
                                viewModel.currentWeatherResult!.weather[0].main,
                                style: theme.getCurrentWeatherText.copyWith(
                                  fontSize: 45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: DropdownButton<WeatherTheme>(
                            value: selectedTheme,
                            onChanged: (WeatherTheme? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedTheme = newValue;
                                });
                              }
                            },
                            items: themes.map((theme) {
                              return DropdownMenuItem<WeatherTheme>(
                                value: theme,
                                child: Text(theme.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DegreesCelsiusValue(
                                  value: viewModel.currentWeatherResult!.main.tempMin,
                                ),
                                DegreesCelsiusValue(
                                  value: viewModel.currentWeatherResult!.main.temp,
                                ),
                                DegreesCelsiusValue(
                                  value: viewModel.currentWeatherResult!.main.tempMax,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "min",
                                  style: theme.getSecondaryText,
                                ),
                                Text(
                                  "current",
                                  style: theme.getSecondaryText,
                                ),
                                Text(
                                  "max",
                                  style: theme.getSecondaryText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.white,
                      height: 0,
                    )
                  ],
                ),
              )),
          ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.forecastWeatherResult?.list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                minLeadingWidth: MediaQuery.of(context).size.width * 0.38,
                leading: Text(
                  (viewModel.forecastWeatherResult!.list[index].dtTxt).toString().formatDateToWeekDay,
                  style: theme.getPrimaryText.copyWith(
                    fontSize: 18,
                  ),
                ),
                title: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      image: AssetImage(AppIcons.clear3x),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                trailing: DegreesCelsiusValue(value: viewModel.forecastWeatherResult!.list[index].main.tempMax),
              );
            },
          ),
        ],
      ),
    );
  }
}
