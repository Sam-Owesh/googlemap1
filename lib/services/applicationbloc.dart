import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gmap/services/geolocator_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  late Position currentLocation;
  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getLocation();
    notifyListeners();
  }
}
