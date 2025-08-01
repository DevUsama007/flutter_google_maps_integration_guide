import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class NetworkIconOnMap extends StatefulWidget {
  const NetworkIconOnMap({super.key});

  @override
  State<NetworkIconOnMap> createState() => _NetworkIconOnMapState();
}

class _NetworkIconOnMapState extends State<NetworkIconOnMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  List<LatLng> _latlng = [
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
  loadData() async {
    for (var i = 0; i < _latlng.length; i++) {
      Uint8List? image = await loadNetworkImage(
          "https://github.com/DevUsama007/firebase_notification/blob/main/assets/json/WhatsApp%20Image%202025-04-06%20at%208.43.45%20AM.jpeg?raw=true");
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetHeight: 50,
        targetWidth: 50,
      );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List markerIcon = byteData!.buffer.asUint8List();
      _markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: _latlng[i],
          icon: BitmapDescriptor.bytes(markerIcon),
          infoWindow:
              InfoWindow(snippet: 'Title for marker $i', title: 'Marker $i'),
        ),
      );
    }
    setState(() {});
  }

  Future<Uint8List> loadNetworkImage(String url) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(url);
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, _) {
        completer.complete(info);
      }),
    );
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
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
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
