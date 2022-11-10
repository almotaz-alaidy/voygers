// // import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// final Uri Facebook = Uri.parse("https://www.facebook.com/");
// Future<void> LancherURLf() async {
//   if (!await launchUrl(Facebook)) {
//     throw 'Could not launch Link';
//   }
// }

// final Uri Instagram = Uri.parse("https://www.instagram.com/");
// Future<void> LancherURLI() async {
//   if (!await launchUrl(Instagram)) {
//     throw 'Could not launch Link';
//   }
// }

// class URlClass extends StatelessWidget {
//   URlClass(
//       {required this.linkIcon,
//       required this.linkExp,
//       required this.linkTitle,
//       required this.myfunction});

//   String? linkTitle;
//   String? linkExp;
//   Uri? linkUrl;
//   // Function myFunction ;
//   Function()? myfunction;

//   IconData? linkIcon;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: myfunction,
//       child: Column(children: [
//         ListTile(
//           title: Text(
//             "$linkTitle",
//             style: TextStyle(
//                 // color: Colors.white,
//                 fontSize: 30),
//           ),
//           subtitle: Text(
//             "$linkExp",
//             style: TextStyle(
//                 // color: Colors.white,
//                 fontSize: 20),
//           ),
//           leading: Icon(
//             linkIcon,
//             // color: Colors.white,
//             size: 60,
//           ),
//         ),
//       ]),
//     );
//   }
// }
