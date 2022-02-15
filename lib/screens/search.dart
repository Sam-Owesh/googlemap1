// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmap/models/place.dart';
import 'package:gmap/services/applicationbloc.dart';
import 'package:gmap/services/geolocator_service.dart';
import 'package:gmap/services/marker_service.dart';
// ignore: unused_import
import 'package:gmap/services/places_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Recess.dart';
import '../models/place.dart';

const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
 
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final markerService = MarkerService();

    // ignore: unused_local_variable
    final geoservice = GeoLocatorService();
    // ignore: unused_local_variable
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    // ignore: missing_required_param
    return FutureProvider(
        create: (context) => placesProvider,
        initialData: [],
        child: Scaffold(
          // ignore: unnecessary_null_comparison
          body: (currentPosition != null)
              ? Consumer<List<Place>>(
                  //Consumer<List<Place>>(
                  builder: (_, places, __) {
                  // ignore: deprecated_member_use, unused_local_variable, unnecessary_null_comparison
                      var markers = (places != null)
                      ? markerService.getMarkers(places)
                      // ignore: deprecated_member_use
                      : <Marker>[];
                  //  if ((places != null)) {
                  // ignore: unnecessary_null_comparison
                  return (places != null)
                      ? Column(
                          //Stack(
                          children: <Widget>[
                          
                            Flexible(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                      bearing: CAMERA_BEARING,
                                      tilt: CAMERA_BEARING,
                                      target: LatLng(currentPosition.latitude,
                                          currentPosition.longitude),
                                      zoom: 9.0),
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: true,
                                  markers: Set<Marker>.of(markers),
                                ),
                              ),
                            ),

                            // ),
                            SizedBox(
                              height: 10.0,
                            ),

                            Expanded(
                              child: ListView.builder(
                                  itemCount: places.length,
                                  itemBuilder: (context, index) {
                                    // ignore: missing_required_param
                                    return FutureProvider(
                                      create: (context) =>
                                          geoservice.getDistance(
                                              currentPosition.latitude,
                                              currentPosition.longitude,
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lat,
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lng),
                                      initialData: null,
                                      child: Card(
                                        child: ListTile(
                                          title: Text(places[index].name),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                             
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Consumer<double>(builder:
                                                  (context, meters, widget) {
                                                return (meters != null)
                                                    ? Text(
                                                        '${places[index].vicinity} \u00b7 ${(meters / 1).round()}meters')
                                                    : Container();
                                              }),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons.directions),
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {
                                              _launchMapsUrl(
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  RatingBarIndicator(
      {double? rating,
      Icon Function(dynamic context, dynamic index)? itembuilder,
      int? itemCount,
      double? itemSize,
      Axis? direction}) {}
  // ignore: unused_element
  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
