import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonOnGoogleMap extends StatefulWidget {
  const PolygonOnGoogleMap({super.key});

  @override
  State<PolygonOnGoogleMap> createState() => _PolygonOnGoogleMapState();
}

class _PolygonOnGoogleMapState extends State<PolygonOnGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> points = [
    LatLng(30.611368946515537, 72.89296023714256),
    LatLng(30.609818, 72.901758),
    LatLng(30.606382633083197, 72.91437499234515),
    LatLng(30.5865732557261, 72.91098942806187),
    LatLng(30.575661421185742, 72.8509983225458),
    LatLng(30.594060323793776, 72.80414206240852),
    LatLng(30.630700085274764, 72.85269391296514),
    LatLng(30.611368946515537, 72.89296023714256)
  ];
  CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(30.611368946515537, 72.89296023714256),
    zoom: 14,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygons.add(
      Polygon(
        polygonId: const PolygonId('polygon_1'),
        points: points,
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeWidth: 2,
      ),
    );
    if (_polygons.contains(LatLng(30.610649144745494, 72.83560730467072))) {
      print('Polygon already exists');
    } else {
      print('out of polygon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygon on Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        polygons: _polygons,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
