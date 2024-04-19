import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/components/loading_widget.dart';
import 'package:weather_app/components/no_data_widget.dart';
import 'package:weather_app/utils/notifier_state.dart';
import 'package:weather_app/values/colors.dart';
import 'package:weather_app/values/icons.dart';
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
      body: Consumer<FavoritesViewModel>(builder: (BuildContext context, FavoritesViewModel favoritesViewModel, _) {
        return ConditionalSwitch.single<LoadingStatus>(
          context: context,
          valueBuilder: (BuildContext context) => favoritesViewModel.status,
          caseBuilders: {
            LoadingStatus.busy: (BuildContext context) => const LoadingWidget(
                  color: AppColors.blue,
                ),
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
    return SafeArea(
      minimum: const EdgeInsets.only(top: 80, left: 20, right: 20),
      child: RefreshIndicator(
        onRefresh: favoritesViewModel.getFavoriteLocations,
        child: Center(
          child: Column(
            children: [
              Text(
                "Favorite Places",
                style: theme.getPrimaryText.copyWith(fontSize: 40, color: AppColors.grey),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: favoritesViewModel.favoriteLocations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          favoritesViewModel.getPlaceDetails(favoritesViewModel.favoriteLocations[index]).then((value) => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      favoritesViewModel.details!.candidates[0].formattedAddress,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width / 3,
                                                height: 50,
                                                child: Image(
                                                  image: NetworkImage(favoritesViewModel.details!.candidates[0].icon),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("City: ${favoritesViewModel.details?.candidates[0].name}"),
                                                  Text("Open Now: ${favoritesViewModel.details?.candidates[0].openingHours.openNow}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Place Type: ${favoritesViewModel.details?.candidates[0].types.first}",
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          FlutterMap(
                                            options: const MapOptions(
                                              initialCenter: LatLng(51.509364, -0.128928),
                                              initialZoom: 9.2,
                                            ),
                                            children: [
                                              RichAttributionWidget(
                                                attributions: [
                                                  TextSourceAttribution(
                                                    'OpenStreetMap contributors',
                                                    onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // setState(() {
                                          //   favoritesViewModel.setDetails = LoadingStatus.completed;
                                          // });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              ));
                        },
                        child: Card(
                          color: AppColors.white,
                          elevation: 2,
                          child: ListTile(
                            leading: const Icon(
                              AppIcons.favorite,
                              color: AppColors.red,
                            ),
                            title: Text(
                              textAlign: TextAlign.center,
                              "${favoritesViewModel.favoriteLocations[index].cityName}, ${favoritesViewModel.favoriteLocations[index].countryCode}",
                              style: theme.getPrimaryText.copyWith(
                                fontSize: 18,
                                color: AppColors.blue,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
