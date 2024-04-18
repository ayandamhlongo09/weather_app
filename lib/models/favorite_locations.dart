class FavoriteLocations {
  String cityName;
  String countryCode;

  FavoriteLocations({required this.cityName, required this.countryCode});

  factory FavoriteLocations.fromJson(Map<String, dynamic> json) => FavoriteLocations(
        cityName: json['cityName'],
        countryCode: json['countryCode'],
      );

  Map<String, dynamic> toJson() => {
        "cityName": cityName,
        "countryCode": countryCode,
      };
}
