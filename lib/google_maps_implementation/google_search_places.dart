import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlaces extends StatefulWidget {
  const GoogleSearchPlaces({super.key});

  @override
  State<GoogleSearchPlaces> createState() => _GoogleSearchPlacesState();
}

class _GoogleSearchPlacesState extends State<GoogleSearchPlaces> {
  Uuid uid = const Uuid();
  TextEditingController _controller = TextEditingController();
  List<dynamic> placesList = [];
  String sessiontoken = DateTime.now().millisecondsSinceEpoch.toString();
  String kPLACES_API_KEY = 'AIzaSyDhHpmTBus6ugN0D4bbPjgwXb4hiqlb-hk';

//   This the link of google map places api:
  String baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  void onChange() {
    if (sessiontoken == null) {
      setState(() {
        sessiontoken = uid.v4();
      });
    } else {
      getSuggestion(_controller.text);
    }
  }

  void getSuggestion(String input) {
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessiontoken';
    http.get(Uri.parse(request)).then((response) {
      if (response.statusCode == 200) {
        // Parse the response and update the UI accordingly
        print('Response: ${response.body}');
        setState(() {
          placesList = jsonDecode(response.body.toString())[
              'predictions']; // Assuming the response is in JSON format
        });
        // You can parse the JSON response here and update your state
      } else {
        print('Error: ${response.statusCode}');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Google Search Places'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Search Places',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // Placeholder for place IDs
                        title: Text(placesList[index]
                            ['description']), // Placeholder for place names
                        onTap: () async {
                          await locationFromAddress(
                                  placesList[index]['description'])
                              .then(
                            (value) {
                              print(value);
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
