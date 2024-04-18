import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:google_huawei_availability/google_huawei_availability.dart';
import 'package:huawei_location/huawei_location.dart';
import 'package:weather_app/models/location_coordinates.dart';
import 'package:weather_app/services/core/geolocating/geolocating.dart';
import 'package:weather_app/helpers/exceptions/network_exceptions.dart';

class GeolocatingImpl implements Geolocating {
  Future<Position> _getCurrentGoogleLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw NetworkTimeoutException("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, timeLimit: const Duration(seconds: 60));
      return position;
    } catch (e) {
      print('problem: $e');
      throw NetworkErrorException();
    }
  }

  Future<Location> _getCurrentHuaweiLocation() async {
    final FusedLocationProviderClient locationService = FusedLocationProviderClient();
    locationService.initFusedLocationService();
    try {
      Location location = await locationService.getLastLocation();

      return location;
    } catch (e) {
      print('problem: $e');
      throw NetworkErrorException();
    }
  }

  @override
  Future<LocationCoordinates> get getLatLongCordinates async {
    double? latitude;
    double? longitude;

    if (!Platform.isIOS) {
      bool? isHuawei = await GoogleHuaweiAvailability.isHuaweiServiceAvailable;

      if (isHuawei ?? false) {
        Location locatiion = await _getCurrentHuaweiLocation();
        latitude = locatiion.latitude;
        longitude = locatiion.longitude;
      } else {
        Position position = await _getCurrentGoogleLocation();
        latitude = position.latitude;
        longitude = position.longitude;
      }
    } else {
      Position position = await _getCurrentGoogleLocation();
      latitude = position.latitude;
      longitude = position.longitude;
    }

    return LocationCoordinates(latitude ?? 0, longitude ?? 0);
  }

  @override
  Future<void> dispose() async {}
}
