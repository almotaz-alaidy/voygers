// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FacebookUrl extends StatelessWidget {
//   FacebookUrl({
//     required this.myplatformIcon,
//     required this.myplatformSubTitle,
//     required this.myplatformTitle,
//   });

//   String? myplatformTitle;
//   String? myplatformSubTitle;
//   IconData? myplatformIcon;

//  final Uri _url = Uri.parse('https://www.facebook.com/almotaz.alaidy/');
//   Future<void> _launchUrl() async {
//     if (!await launchUrl(_url)) {
//       throw 'Could not launch $_url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _launchUrl,
//       child: Container(
//           child: ListTile(
//         leading: Icon(myplatformIcon),
//         title: Text("$myplatformTitle"),
//         subtitle: Text("$myplatformSubTitle"),
//       )),
//     );
//   }
// }