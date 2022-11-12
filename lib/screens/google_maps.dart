import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Google_Maps extends StatefulWidget {
  const Google_Maps({super.key});

  @override
  State<Google_Maps> createState() => _Google_MapsState();
}

class _Google_MapsState extends State<Google_Maps> {
  // List<Marker> my_list = [
  //   Marker(
  //     markerId: MarkerId("1"),
  //     position: LatLng(32.637843, 35.940253),
  //   ),
  //   Marker(
  //     markerId: MarkerId("2"),
  //     position: LatLng(31.869301, 35.842089),
  //   )
  // ];
  // List<Polyline> myPolyline = [
  //   Polyline(
  //     polylineId: PolylineId("_kPolyline"),
  //     points: [
  //       LatLng(32.637843, 35.940253),
  //       LatLng(31.869301, 35.842089),
  //     ],
  //     width: 5,
  //   )
  // ];
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
      ),
      body: GoogleMap(
        // onTap: (argument) {
        //   setState(() {
        //     my_list.add(Marker(markerId: MarkerId("3"), position: (argument)));
        //   });
        // },
        mapType: MapType.satellite,

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
