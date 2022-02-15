// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gmap/example.dart';
import 'package:gmap/models/place.dart';
import 'package:gmap/screens/search.dart';
import 'package:gmap/services/applicationbloc.dart';
import 'package:gmap/services/geolocator_service.dart';
import 'package:gmap/services/places_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ignore: missing_required_param
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: ChangeNotifierProvider(
        create: (context) => ApplicationBloc(),
        child: MaterialApp(
          title: ' GymLocatorApp',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: Search(),
        ),
      ),
    );
  }
}
