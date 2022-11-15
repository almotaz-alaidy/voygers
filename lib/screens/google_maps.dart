import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

late String docForloc;

class Google_Maps extends StatefulWidget {
  const Google_Maps({super.key});

  @override
  State<Google_Maps> createState() => _Google_MapsState();
}

class _Google_MapsState extends State<Google_Maps> {
  var alt;
  var long;
  var _trip_location;
  List<Marker> my_list = [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(32.637843, 35.940253),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(31.869301, 35.842089),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen))
  ];
  List<Polyline> myPolyline = [
    Polyline(
      polylineId: PolylineId("_kPolyline"),
      points: [
        LatLng(32.637843, 35.940253),
        LatLng(31.869301, 35.842089),
      ],
      width: 5,
    )
  ];
  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      value.altitude;
      value.longitude;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
        backgroundColor: Colors.green,
        actions: [
          TextButton(
            onPressed: () {
              try {
                FirebaseFirestore db = FirebaseFirestore.instance;

                Map<String, dynamic> location = {
                  "lat": alt,
                  "long": long,
                };

                db
                    .collection("loc")
                    .add(location)
                    .then((DocumentReference doc) {
                  docForloc = doc.id.toString();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("location saved succecfully")));
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Try again!")));
              }
            },
            child: Image.asset(
              "images/location.png",
              color: Colors.white,
            ),
          )
        ],
      ),
      body: GoogleMap(
        markers: my_list.toSet(),
        onTap: (argument) {
          setState(() {
            _trip_location = argument;
            my_list.add(Marker(
                markerId: MarkerId("3"),
                position: (argument),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen)));
          });
          alt = argument.latitude;
          long = argument.longitude;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(31.897863, 35.868265),
          zoom: 15,
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
