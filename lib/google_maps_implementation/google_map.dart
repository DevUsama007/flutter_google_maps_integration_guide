import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();

  //camera position for the map
  //you can change the coordinates to your desired location
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(30.61420, 72.92104),
    zoom: 14.4746,
  );

  //markers for the map
  //you can add more markers to the list
  List<Marker> _markers = [];
  List<Marker> _listMarker = [
    Marker(
        markerId: MarkerId("1"),
        position: const LatLng(30.61420, 72.92104),
        infoWindow: InfoWindow(title: "Usama Jutt", snippet: "Jutt Houses")),
    Marker(
        markerId: MarkerId("2"),
        position: const LatLng(30.61720, 72.92204),
        infoWindow: InfoWindow(title: "Hassan Jutt", snippet: "Jutt Houses")),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(_listMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //MOVE THE CAMERA TO ANY POSSITION ON MAP
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(30.61420, 72.92104),
            zoom: 14.4746,
          )));
        },
      ),
      body: GoogleMap(
        compassEnabled: true,
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
