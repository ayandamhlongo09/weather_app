import 'package:flutter/material.dart';

class AppIcons {
  static const String iconeDir = "assets/icons";

  //Clear
  static const String sunny = "$iconeDir/clear.png";
  static const String sunny2x = "$iconeDir/clear@2x.png";
  static const String sunny3x = "$iconeDir/clear@3x.png";

  //Partly Sunny
  static const String cloudy = "$iconeDir/partlysunny.png";
  static const String cloudy2x = "$iconeDir/partlysunny@2x.png";
  static const String cloudy3x = "$iconeDir/partlysunny@3x.png";

  //Rain
  static const String rain = "$iconeDir/rain.png";
  static const String rain2x = "$iconeDir/rain@2x.png";
  static const String rain3x = "$iconeDir/rain@3x.png";

  //Bottom Naviagtion Icons
  static const Icon home = Icon(Icons.home);
  static const Icon favorites = Icon(Icons.favorite);
  static const IconData favorite = IconData(0xe25b, fontFamily: 'MaterialIcons');
}
