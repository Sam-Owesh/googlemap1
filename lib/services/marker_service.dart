import 'package:gmap/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  Set<Marker> getMarkers(List<Place> places) {
    // ignore: deprecated_member_use, unused_local_variable
     final Set<Marker> markers = new Set();
    places.forEach((place) {
      Marker marker = Marker(
          markerId: MarkerId(place.name),
          draggable: false,
          infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng));
      markers.add(marker);
    });
    return markers;
  }
}
