import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(144, 7, 211, 20),
        title: Text(
          "Personal Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // color: Colors.purple,
            fontSize: 40,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //     gradient: SweepGradient(colors: [
        //   Color.fromARGB(255, 162, 0, 187),
        //   Color.fromARGB(255, 230, 141, 171),
        //   Colors.purple,
        //   Color.fromARGB(255, 230, 141, 171),
        //   Color.fromARGB(255, 167, 0, 193),
        // ])),
        child: Center(
            child: Text(
          "Profile",
          style: TextStyle(
              // color: Colors.white,
              fontSize: 40),
        )),
      ),
    );
  }
}
