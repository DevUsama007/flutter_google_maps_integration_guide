import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLinesOnGoogleMap extends StatefulWidget {
  const PolyLinesOnGoogleMap({super.key});

  @override
  State<PolyLinesOnGoogleMap> createState() => _PolyLinesOnGoogleMapState();
}

class _PolyLinesOnGoogleMapState extends State<PolyLinesOnGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> points = [
    LatLng(30.611368946515537, 72.89296023714256),
    LatLng(30.609818, 72.901758),
    LatLng(30.606382633083197, 72.91437499234515),
    LatLng(30.5865732557261, 72.91098942806187),
    LatLng(30.575661421185742, 72.8509983225458),
    LatLng(30.594060323793776, 72.80414206240852),
    LatLng(30.630700085274764, 72.85269391296514),
  ];
  CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(30.611368946515537, 72.89296023714256),
    zoom: 14,
  );

  void loadData() {
    for (var i = 0; i < points.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: points[i],
          infoWindow: InfoWindow(title: 'Marker $i'),
        ),
      );
    }
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('polyline_1'),
        points: points,
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
