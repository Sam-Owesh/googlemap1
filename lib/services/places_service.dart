// ignore: unused_import
// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:gmap/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final String key = 'AIzaSyATHhkFU0a6YLIusKCPaxFxA1jgdwkRFpM';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get(Uri.parse(
       // 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat}%2C${lng}&radius=1000&type=gym&key=${key}'
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat%2C$lng&radius=1000&type=gym&key=$key'
        ));
    
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
  
}

