import 'dart:async';

import 'package:weather_app/models/location_coordinates.dart';

abstract class Geolocating {
  Future<LocationCoordinates> get getLatLongCordinates;

  Future<void> dispose();
}
