import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/core/geolocating/geolocating.dart';
import 'package:weather_app/helpers/exceptions/network_exceptions.dart';

class GeolocatingImpl implements Geolocating {
  @override
  Future<Position> get getCurrentLocation async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationPermissionsException("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionsException("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionsException("Location permissions are permanently denied, we cannot request permissions.");
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  Future<void> dispose() async {}
}
