import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/google_maps_implementation/add_marker_with_icon.dart';
import 'package:google_maps_in_flutter/google_maps_implementation/convert_cordinates_to_address.dart';
import 'package:google_maps_in_flutter/google_maps_implementation/custom_marker_window_info.dart';
import 'package:google_maps_in_flutter/google_maps_implementation/get_current_location.dart';
import 'package:google_maps_in_flutter/google_maps_implementation/google_map.dart';
import 'package:google_maps_in_flutter/google_maps_implementation/google_search_places.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Google Maps in Flutter'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image1.png',
                width: 90,
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ConvertCordinatesToAddress(),
                      ),
                    );
                  },
                  child: const Text('Go to Convert Coordinates'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoogleMaps(),
                      ),
                    );
                  },
                  child: const Text('Go to Google Maps'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GetCurrentLocation(),
                      ),
                    );
                  },
                  child: const Text('Get Current Location'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoogleSearchPlaces(),
                      ),
                    );
                  },
                  child: const Text('Google Search Places'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddMarkerWithIcon(),
                      ),
                    );
                  },
                  child: const Text('Add Marker with Icon'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomMarkerWindowInfo(),
                      ),
                    );
                  },
                  child: const Text('Custom Marker Window Info'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
