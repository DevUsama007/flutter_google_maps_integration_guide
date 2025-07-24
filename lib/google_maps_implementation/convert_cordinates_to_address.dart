import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertCordinatesToAddress extends StatefulWidget {
  const ConvertCordinatesToAddress({super.key});

  @override
  State<ConvertCordinatesToAddress> createState() =>
      _ConvertCordinatesToAddressState();
}

class _ConvertCordinatesToAddressState
    extends State<ConvertCordinatesToAddress> {
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String address = '';
  String coordinates = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Convert Coordinates to Address'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: latitudeController,
                  decoration: InputDecoration(
                    label: Text('Latitude'),
                    hintText: 'Enter latitude',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: longitudeController,
                  decoration: InputDecoration(
                    label: Text('Longitude'),
                    hintText: 'Enter longitude',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Address: $address"),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      address = 'processing...';
                      setState(() {});
                      final latitude = double.parse(latitudeController.text);
                      final longitude = double.parse(longitudeController.text);
                      // Implement the conversion logic here
                      placemarkFromCoordinates(latitude, longitude)
                          .then((value) {
                        print(value.reversed.last.country.toString());
                        setState(() {
                          address = value.first.street.toString() +
                              ', ' +
                              value.reversed.last.country.toString();
                        });
                      }).onError(
                        (error, stackTrace) {
                          print(error);
                        },
                      );
                    },
                    child: const Text("Convert to Address")),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    label: Text('Address'),
                    hintText: 'Enter address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Coordinates: ${coordinates}"),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      // Implement the conversion logic here
                      locationFromAddress(addressController.text)
                          .then((locations) {
                        var output = 'No results found.';
                        if (locations.isNotEmpty) {
                          output = locations[0].toString();
                          longitudeController.text =
                              locations[0].longitude.toString();
                          latitudeController.text =
                              locations[0].latitude.toString();
                        }
                        setState(() {
                          coordinates = output;
                        });
                      });
                    },
                    child: const Text("Convert to Coordinates")),
              ],
            ),
          ),
        ));
  }
}
