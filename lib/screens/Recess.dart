// To parse this JSON data, do
//
//     final recess = recessFromJson(jsonString);

import 'dart:convert';

Recess recessFromJson(String str) => Recess.fromJson(json.decode(str));

String recessToJson(Recess data) => json.encode(data.toJson());

class Recess {
  Recess({
    required this.htmlAttributions,
    required this.nextPageToken,
    required this.results,
    required this.status,
  });

  List<dynamic> htmlAttributions;
  String nextPageToken;
  List<Result> results;
  String status;

  factory Recess.fromJson(Map<String, dynamic> json) => Recess(
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        nextPageToken: json["next_page_token"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "next_page_token": nextPageToken,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
      };
}

class Result {
  Result({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.openingHours,
    required this.placeId,
    required this.plusCode,
    required this.reference,
    required this.scope,
    required this.types,
    required this.vicinity,
    required this.photos,
    required this.permanentlyClosed,
    required this.rating,
    required this.userRatingsTotal,
  });

  BusinessStatus? businessStatus;
  Geometry geometry;
  String icon;
  IconBackgroundColor? iconBackgroundColor;
  String iconMaskBaseUri;
  String name;
  OpeningHours? openingHours;
  String placeId;
  PlusCode? plusCode;
  String reference;
  Scope? scope;
  List<String> types;
  String vicinity;
  List<Photo>? photos;
  bool permanentlyClosed;
  double rating;
  int userRatingsTotal;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        businessStatus: businessStatusValues.map[json["business_status"]],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor:
            iconBackgroundColorValues.map[json["icon_background_color"]],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
        reference: json["reference"],
        scope: scopeValues.map[json["scope"]],
        types: List<String>.from(json["types"].map((x) => x)),
        vicinity: json["vicinity"],
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        permanentlyClosed: json["permanently_closed"] == null
            ? null
            : json["permanently_closed"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        userRatingsTotal: json["user_ratings_total"] == null
            ? null
            : json["user_ratings_total"],
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatusValues.reverse[businessStatus],
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color":
            iconBackgroundColorValues.reverse[iconBackgroundColor],
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours == null ? null : openingHours?.toJson(),
        "place_id": placeId,
        "plus_code": plusCode == null ? null : plusCode?.toJson(),
        "reference": reference,
        "scope": scopeValues.reverse[scope],
        "types": List<dynamic>.from(types.map((x) => x)),
        "vicinity": vicinity,
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "permanently_closed":
            permanentlyClosed == null ? null : permanentlyClosed,
        "rating": rating == null ? null : rating,
        "user_ratings_total":
            userRatingsTotal == null ? null : userRatingsTotal,
      };
}

enum BusinessStatus { OPERATIONAL, CLOSED_TEMPORARILY }

final businessStatusValues = EnumValues({
  "CLOSED_TEMPORARILY": BusinessStatus.CLOSED_TEMPORARILY,
  "OPERATIONAL": BusinessStatus.OPERATIONAL
});

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

enum IconBackgroundColor { THE_7_B9_EB0, THE_4_B96_F3, THE_909_CE1 }

final iconBackgroundColorValues = EnumValues({
  "#4B96F3": IconBackgroundColor.THE_4_B96_F3,
  "#7B9EB0": IconBackgroundColor.THE_7_B9_EB0,
  "#909CE1": IconBackgroundColor.THE_909_CE1
});

class OpeningHours {
  OpeningHours({
    required this.openNow,
  });

  bool openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions:
            List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  CompoundCode? compoundCode;
  GlobalCode? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: compoundCodeValues.map[json["compound_code"]],
        globalCode: globalCodeValues.map[json["global_code"]],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCodeValues.reverse[compoundCode],
        "global_code": globalCodeValues.reverse[globalCode],
      };
}

enum CompoundCode { THE_8_HXJ_2_X_KAMPALA_UGANDA }

final compoundCodeValues = EnumValues(
    {"8HXJ+2X Kampala, Uganda": CompoundCode.THE_8_HXJ_2_X_KAMPALA_UGANDA});

enum GlobalCode { THE_6_GGJ8_HXJ_2_X }

final globalCodeValues =
    EnumValues({"6GGJ8HXJ+2X": GlobalCode.THE_6_GGJ8_HXJ_2_X});

enum Scope { GOOGLE }

final scopeValues = EnumValues({"GOOGLE": Scope.GOOGLE});

class EnumValues<T> {
  Map<String, T> map;
 late Map<T, String> reverseMap;

  EnumValues(this.map);
  
  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
