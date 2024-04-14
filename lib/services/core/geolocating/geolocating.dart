import 'dart:async';

abstract class Geolocating {
  Future get getCurrentLocation;
  Future<void> dispose();
}
