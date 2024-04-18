import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/loading_widget.dart';
import 'package:weather_app/components/no_data_widget.dart';
import 'package:weather_app/utils/notifier_state.dart';
import 'package:weather_app/values/colors.dart';
import 'package:weather_app/values/theme.dart';
import 'package:weather_app/viewmodels/favorites_viewmodel.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final CustomTheme theme = CustomTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Places"),
      ),
      body: Consumer<FavoritesViewModel>(builder: (BuildContext context, FavoritesViewModel favoritesViewModel, _) {
        return ConditionalSwitch.single<LoadingStatus>(
          context: context,
          valueBuilder: (BuildContext context) => favoritesViewModel.status,
          caseBuilders: {
            LoadingStatus.busy: (BuildContext context) => const LoadingWidget(),
            LoadingStatus.failed: (BuildContext context) => const NoDataWidget(message: 'No saved favorite locations'),
            LoadingStatus.idle: (BuildContext context) => const LoadingWidget(),
            LoadingStatus.completed: (BuildContext context) => favoritesList(context: context, favoritesViewModel: favoritesViewModel),
          },
          fallbackBuilder: (BuildContext context) => const SizedBox(),
        );
      }),
    );
  }

  Widget favoritesList({required BuildContext context, required FavoritesViewModel favoritesViewModel}) {
    return Center(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: favoritesViewModel.favoriteLocations.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  favoritesViewModel.favoriteLocations[index].cityName,
                  style: theme.getPrimaryText.copyWith(
                    fontSize: 18,
                    color: AppColors.blue,
                  ),
                ),
                trailing: Text(
                  favoritesViewModel.favoriteLocations[index].countryCode,
                  style: theme.getPrimaryText.copyWith(
                    fontSize: 18,
                    color: AppColors.blue,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
