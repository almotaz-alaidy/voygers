import 'package:flutter/material.dart';
import 'package:voygares/compononet/customtextfeild.dart';

class JoinTrip extends StatefulWidget {
  const JoinTrip({super.key});

  @override
  State<JoinTrip> createState() => _JoinTripState();
}

class _JoinTripState extends State<JoinTrip> {
  TextEditingController _code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "joining the trip ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextfeild(controller: _code, text: "Enter Your code"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "trip_page");
              },
              child: Text("Join"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
