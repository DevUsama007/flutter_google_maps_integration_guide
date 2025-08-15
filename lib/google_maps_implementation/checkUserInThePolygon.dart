import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CheckUserInPolygon extends StatefulWidget {
  const CheckUserInPolygon({super.key});

  @override
  State<CheckUserInPolygon> createState() => _CheckUserInPolygonState();
}

class _CheckUserInPolygonState extends State<CheckUserInPolygon> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Marker> _markers = {};
  final location = Location();
  late PermissionStatus _permissionGranted;
  List<LatLng> points = [
    LatLng(30.611368946515537, 72.89296023714256),
    LatLng(30.609818, 72.901758),
    LatLng(30.6141857, 72.9210587),
    LatLng(30.606382633083197, 72.91437499234515),
    LatLng(30.5865732557261, 72.91098942806187),
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

    _checkUserLocation();
  }

  Future<void> _checkUserLocation() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null; // Permission denied
      }
    }

    // Get current location
    LocationData _locationData = await location.getLocation();
    LatLng userLocation =
        LatLng(_locationData.latitude!, _locationData.longitude!);
    // LocationData _locationData = await location.getLocation();
    // LatLng userLocation =
    //     LatLng(_locationData.latitude!, _locationData.longitude!);
    print("User location: $userLocation");

    // Add marker for user location
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId("user_marker"),
        position: userLocation,
      ));
    });

    // Check if inside polygon
    if (_isPointInPolygon(userLocation, points)) {
      print("✅ User is inside polygon");
    } else {
      print("❌ User is outside polygon");
    }
  }

  /// Ray-casting algorithm for "point in polygon"
  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersectCount = 0;
    for (int j = 0; j < polygon.length - 1; j++) {
      if (rayCastIntersect(point, polygon[j], polygon[j + 1])) {
        intersectCount++;
      }
    }
    return (intersectCount % 2) == 1; // odd = inside, even = outside
  }

  bool rayCastIntersect(LatLng point, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = point.latitude;
    double pX = point.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false;
    }

    double m = (bY - aY) / (bX - aX);
    double bee = (-aX) * m + aY;
    double x = (pY - bee) / m;

    return x > pX;
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
