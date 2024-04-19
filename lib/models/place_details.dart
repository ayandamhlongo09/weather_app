import 'dart:convert';

class PlaceDetails {
  List<Candidate> candidates;
  String status;

  PlaceDetails({
    required this.candidates,
    required this.status,
  });

  factory PlaceDetails.fromRawJson(String str) => PlaceDetails.fromJson(json.decode(str));

  factory PlaceDetails.fromJson(Map<String, dynamic> json) => PlaceDetails(
        candidates: List<Candidate>.from(json["candidates"].map((x) => Candidate.fromJson(x))),
        status: json["status"],
      );
}

class Candidate {
  String formattedAddress;
  Geometry geometry;
  String icon;
  String name;

  OpeningHours openingHours;
  List<Photo> photos;
  double rating;
  String placeId;
  List<String> types;

  Candidate({
    required this.formattedAddress,
    required this.geometry,
    required this.icon,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.rating,
    required this.placeId,
    required this.types,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"] ?? {}),
        icon: json["icon"],
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"] ?? {}),
        photos: List<Photo>.from((json["photos"] ?? []).map((x) => Photo.fromJson(x))),
        rating: (json["rating"]) ?? 0.toDouble(),
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
      );
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );
}

class OpeningHours {
  bool openNow;

  OpeningHours({
    required this.openNow,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"] ?? false,
      );
}

class Photo {
  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );
}
