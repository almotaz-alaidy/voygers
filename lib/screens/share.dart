import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../wedget/url.dart';

class Share extends StatefulWidget {
  const Share({super.key});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 600,
      // decoration: BoxDecoration(
      //     gradient: SweepGradient(colors: [
      //   Color.fromARGB(255, 162, 0, 187),
      //   Color.fromARGB(255, 230, 141, 171),
      //   Colors.purple,
      //   Color.fromARGB(255, 230, 141, 171),
      //   Color.fromARGB(255, 167, 0, 193),
      // ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "share your trip code",
            style: TextStyle(
                // color: Colors.white,
                fontSize: 40),
          ),
          URlClass(
              myfunction: LancherURLf,
              linkIcon: Ionicons.logo_facebook,
              linkExp: "share your trip code",
              linkTitle: "FaceBook"),
          URlClass(
              myfunction: LancherURLI,
              linkIcon: Ionicons.logo_instagram,
              linkExp: "share your trip code",
              linkTitle: "Instagram"),
        ],
      ),
    ));
  }
}
