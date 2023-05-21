import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hsl_frontend_app/FilterJourney.dart';
import 'package:hsl_frontend_app/StationList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StationSingleView extends StatefulWidget {
  const StationSingleView({required this.station});
  final FinalStationList station;

  @override
  State<StationSingleView> createState() => _StationSingleViewState();
}

class _StationSingleViewState extends State<StationSingleView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String lat = "0";
  String lng = "0";

  String avgDeparture = '';
  String avgReturn = '';
  int totalDeparture = 0;
  int totalReturn = 0;

  Future<void> _loadData() async {
    final url = Uri.parse('http://hsl-backend-app.herokuapp.com/FilterJourney');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({"nimi": widget.station.Nimi});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final apiResponse = FilterJourney.fromJson(json.decode(response.body));
      setState(() {
        avgDeparture = apiResponse.avgDeparture;
        avgReturn = apiResponse.avgReturn;
        totalDeparture = apiResponse.totalDeparture;
        totalReturn = apiResponse.totalReturn;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error fetching data from API with response code ${response.statusCode}Exit to return to previous page'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Exit',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ));
      // Handle API error
    }
  }

  @override
  void initState() {
    if (double.tryParse(widget.station.y) != null ||
        double.tryParse(widget.station.y) != null) {
      setState(() {
        lat = widget.station.y;
        lng = widget.station.x;
      });
    }
    _loadData();
    super.initState();
  }

  // ignore: prefer_final_fields
  late CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(double.parse(lat), double.parse(lng)),
      tilt: 0,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 246, 255),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          double.parse(lat) == 0 || double.parse(lng) == 0
              ? Column(
                  children: [
                    const SizedBox(height: 150),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "No location found with Lattitude: ${widget.station.y} and Longitude: ${widget.station.x}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .6,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                          markerId: const MarkerId("marker1"),
                          position:
                              LatLng(double.parse(lat), double.parse(lng)),
                        ),
                      },
                      initialCameraPosition: _kLake,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              widget.station.Name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              "Station",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            childrenPadding: const EdgeInsets.all(0),
            children: <Widget>[
              ListTile(
                title: const Text(
                  "Address: ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: Text(
                  widget.station.Adress,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                title: const Text(
                  "Average Return Distance: ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: Text(
                  avgReturn,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                title: const Text(
                  "Average Departure Distance: ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: Text(
                  avgDeparture,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                title: const Text(
                  "Total Return Trips Number: ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: Text(
                  '$totalReturn',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                title: const Text(
                  "Total Departure Trips Number: ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: Text(
                  '$totalDeparture',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              // ListTile(
              //   title: const Text(
              //     "Total Departure: ",
              //     style: TextStyle(fontWeight: FontWeight.w700),
              //   ),
              //   trailing: Text(
              //     "${widget.totalDeparture}",
              //     style: const TextStyle(fontWeight: FontWeight.w700),
              //   ),
              // ),
              // ListTile(
              //   title: const Text(
              //     "Total Return: ",
              //     style: TextStyle(fontWeight: FontWeight.w700),
              //   ),
              //   trailing: Text(
              //     "${widget.totalReturn}",
              //     style: const TextStyle(fontWeight: FontWeight.w700),
              //   ),
              // ),
              // ListTile(
              //   title: const Text(
              //     "Average Distance of Departures: ",
              //     style: TextStyle(fontWeight: FontWeight.w700),
              //   ),
              //   trailing: Text(
              //     calculateAvgDeparture(widget.station) as String,
              //     style: const TextStyle(fontWeight: FontWeight.w700),
              //   ),
              // ),
              // ListTile(
              //   title: const Text(
              //     "Average Distance of Returns: ",
              //     style: TextStyle(
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              //   trailing: Text(
              //     calculateAvgReturn(widget.station) as String,
              //     style: const TextStyle(
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }
}
