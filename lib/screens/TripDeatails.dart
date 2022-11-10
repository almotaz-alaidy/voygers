import 'package:flutter/material.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "voygers",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context, "trip_page"),
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
          "Trip Details",
          style: TextStyle(fontSize: 40),
        )),
      ),
    );
  }
}
