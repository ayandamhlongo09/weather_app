import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/degrees_celsius_value.dart';
import 'package:weather_app/components/loading_widget.dart';
import 'package:weather_app/components/no_data_widget.dart';
import 'package:weather_app/helpers/string_extension.dart';
import 'package:weather_app/utils/notifier_state.dart';
import 'package:weather_app/values/colors.dart';
import 'package:weather_app/values/icons.dart';
import 'package:weather_app/values/images.dart';
import 'package:weather_app/values/styles.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CustomTheme theme = CustomTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
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
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      const Image(
                        width: double.infinity,
                        image: AssetImage(ImagePath.seaSunny),
                        fit: BoxFit.fitWidth,
                      ),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage(ImagePath.forestSunny), // Replace 'assets/sea_cloudy.jpg' with your image path
                      //       fit: BoxFit.fitWidth, // Upscale the image to its original size
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 8, // Adjust this value as needed
                        left: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
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
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.blue,
                      ),
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
          // physics: const ScrollPhysics(),
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
    );
  }
}
