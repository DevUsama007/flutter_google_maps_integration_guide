import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({super.key});

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  final location = Location();

  Completer<GoogleMapController> _controller = Completer();

  Future<LocationData?> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null; // Service not enabled
      }
    }

    // Check for permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null; // Permission denied
      }
    }

    // Get current location
    LocationData _locationData = await location.getLocation();
    return _locationData;
  }

  List<Marker> _markers = [];
  List<Marker> _listMarker = [
    Marker(
        markerId: MarkerId("1"),
        position: const LatLng(40.614185, 12.9210633),
        infoWindow: InfoWindow(title: "Hamza Jutt", snippet: "Jutt Houses")),
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
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Get Current Location'),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: GoogleMap(
                markers: Set<Marker>.of(_markers),
                initialCameraPosition: const CameraPosition(
                  target: LatLng(40.614185,
                      12.9210633), // Example coordinates (San Francisco)
                  zoom: 10,
                ),
                onMapCreated: (GoogleMapController controller) {
                  // You can add additional setup here if needed
                  _controller.complete(controller);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size(300, 40)),
                  backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                ),
                onPressed: () {
                  getCurrentLocation().then((value) async {
                    // set the camera possiton
                    print("object");
                    setState(() {});
                    final latitude = double.parse(value!.latitude.toString());
                    final longitude = double.parse(value.longitude.toString());
                    print("Latitude: $latitude, Longitude: $longitude");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'latitude ${latitude.toString()} \n longitude ${longitude.toString()}'),
                      ),
                    );

                    // add the marker
                    _markers.add(Marker(
                      markerId: MarkerId("current_location"),
                      position: LatLng(latitude, longitude),
                      infoWindow: InfoWindow(
                        title: "Current Location",
                        snippet:
                            "Lat: ${value.latitude}, Lng: ${value.longitude}",
                      ),
                    ));
                    GoogleMapController controller = await _controller.future;
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: 14.4746,
                    )));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'latitude ${latitude.toString()} \n longitude ${longitude.toString()}'),
                      ),
                    );
                    setState(() {});
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error fetching location: $error'),
                      ),
                    );
                  });
                },
                child: Text('Get Current Location'))
          ],
        ));
  }
}
