import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/6.jpg"), fit: BoxFit.fill)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            child: Text(
              " VOYGARES",
              style: TextStyle(fontSize: 40, color: Colors.white
                  // fontFamily: "Changa-VariableFont_wght"
                  ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Great choice to Organize your trips",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: "Changa-VariableFont_wght"),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Text(
          //     "The Voyager application is an application that facilitates the organization of trips so that you can perform many services to facilitate all the obstacles that you may encounter during your trip",
          //     style: TextStyle(
          //       fontSize: 25,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}
