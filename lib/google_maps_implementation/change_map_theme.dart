import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChangeMapTheme extends StatefulWidget {
  const ChangeMapTheme({super.key});

  @override
  State<ChangeMapTheme> createState() => _ChangeMapThemeState();
}

class _ChangeMapThemeState extends State<ChangeMapTheme> {
  String mapTheme = '';
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(30.611368946515537, 72.89296023714256),
    zoom: 14,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/night_theme.json')
        .then(
      (value) {
        mapTheme = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Change the App Theme'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/night_theme.json')
                        .then(
                      (string) {
                        mapTheme = string;
                        setState(() {});
                      },
                    );
                  },
                  child: Text("Night Theme")),
              PopupMenuItem(
                  onTap: () {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/retro_theme.json')
                        .then(
                      (string) {
                        mapTheme = string;
                        setState(() {});

                        print(mapTheme);
                      },
                    );
                  },
                  child: Text("Retro Theme")),
              PopupMenuItem(
                  onTap: () {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/silver_theme.json')
                        .then(
                      (string) {
                        mapTheme = string;
                        setState(() {});
                      },
                    );
                  },
                  child: Text("Silver Theme")),
            ],
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        style: mapTheme,
        onMapCreated: (controller) {},
      ),
    );
  }
}
