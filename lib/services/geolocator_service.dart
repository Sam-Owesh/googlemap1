import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  final geolocator = Geolocator();
 
  Future<Position> getLocation() async {
    // ignore: unused_local_variable
    var geolocator = Geolocator();
    // ignore: unused_local_variable
    LocationPermission permission = await Geolocator.requestPermission();
       
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        
  }
  

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return  Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
