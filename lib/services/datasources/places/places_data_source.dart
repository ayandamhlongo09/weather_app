
import 'package:weather_app/models/favorite_locations.dart';
import 'package:weather_app/models/place_details.dart';

abstract class PlacesDataSource {
  Future<PlaceDetails> getPlaceDetails(FavoriteLocations location);
}
