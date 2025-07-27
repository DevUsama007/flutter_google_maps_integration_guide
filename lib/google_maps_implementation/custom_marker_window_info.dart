import 'package:flutter/material.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerWindowInfo extends StatefulWidget {
  const CustomMarkerWindowInfo({super.key});

  @override
  State<CustomMarkerWindowInfo> createState() => _CustomMarkerWindowInfoState();
}

class _CustomMarkerWindowInfoState extends State<CustomMarkerWindowInfo> {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
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
  loadData() {
    for (var i = 0; i < _latLang.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(
          i.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLang[i],
        onTap: () {
          customInfoWindowController.addInfoWindow!(
              Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 253, 251, 251),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: const Color.fromARGB(255, 192, 190, 190)),
                          child: Image.asset(
                            'assets/image1.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      Text(
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          'This is custom marker window info created by usama for car')
                    ],
                  )),
              _latLang[i]);
        },
      ));
    }
    setState(() {});
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.61420, 72.92104),
              zoom: 14.4746,
            ),
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
            onTap: (possition) {
              customInfoWindowController.hideInfoWindow!();
            },
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowController.googleMapController = controller;
            },
            markers: Set<Marker>.of(_markers),
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 100,
            width: 200,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
