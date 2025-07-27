import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class AddMarkerWithIcon extends StatefulWidget {
  const AddMarkerWithIcon({super.key});

  @override
  State<AddMarkerWithIcon> createState() => _AddMarkerWithIconState();
}

class _AddMarkerWithIconState extends State<AddMarkerWithIcon> {
  // custom marker icon
  Uint8List? markerImage;
  Completer<GoogleMapController> _controller = Completer();
  List<String> markerIcons = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
    'assets/image5.png',
    'assets/image6.png',
    'assets/image7.png',
  ];
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(30.61420, 72.92104),
    zoom: 14.4746,
  );
  List<Marker> _markers = [];
  final List<LatLng> _latLang = <LatLng>[
    LatLng(30.61420, 72.92104),
    LatLng(30.61720, 72.92204),
    LatLng(30.62020, 72.92304),
    LatLng(30.62320, 72.92404),
    LatLng(30.62620, 72.92504),
    LatLng(30.62920, 72.92604),
    LatLng(30.63220, 72.92704),
  ];

  loadData() async {
    for (int i = 0; i < _latLang.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(markerIcons[i], 50);
      _markers.add(Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: _latLang[i],
          icon: BitmapDescriptor.bytes(markerIcon),
          infoWindow: InfoWindow(title: 'Marker no is ${i + 1}')));
    }
    setState(() {});
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  initState() {
    super.initState();
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("1"),
    //     position: LatLng(30.61420, 72.92104),
    //     infoWindow: InfoWindow(title: 'My Location'),
    //   ),
    // );
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
