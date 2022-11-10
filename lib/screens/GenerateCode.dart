// import 'dart:math';

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'bottom_appbar.dart';

// class GenerateCode extends StatefulWidget {
//   const GenerateCode({super.key});

//   @override
//   State<GenerateCode> createState() => _GenerateCodeState();
// }

// class _GenerateCodeState extends State<GenerateCode> {
//   String generated_code = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text(
//             "Let The Fun Start",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         body: Container(
//           width: 600,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 generated_code,
//                 style: TextStyle(backgroundColor: Colors.white, fontSize: 30),
//               ),
//               TextButton.icon(
//                   onPressed: () {
//                     setState(() {
//                       generated_code = getBase64RandomString(8);
//                     });
//                   },
//                   icon: Icon(
//                     Icons.generating_tokens,
//                     color: Colors.green,
//                   ),
//                   label: Text(
//                     "Generate",
//                     style: TextStyle(
//                       fontSize: 50,
//                       color: Colors.green,
//                     ),
//                   )),
//               TextButton.icon(
//                   onPressed: () {
//                     setState(
//                       () {
//                         Clipboard.setData(
//                           ClipboardData(text: generated_code),
//                         );
//                       },
//                     );
//                   },
//                   icon: Icon(
//                     Icons.copy,
//                     color: Colors.green,
//                   ),
//                   label: Text(
//                     "copy",
//                     style: TextStyle(
//                       fontSize: 50,
//                       color: Colors.green,
//                     ),
//                   )),
//               TextButton.icon(
//                 onPressed: () async {
//                   try {
//                     FirebaseFirestore db = FirebaseFirestore.instance;

//                     Map<String, dynamic> userInfo = {"code": generated_code};
//                     db.collection("code").add(userInfo).then(
//                           (DocumentReference doc) => print(
//                               'DocumentSnapshot added with ID: ${doc.id}'),
//                         );
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Code Generated")));
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("Try again!"),
//                       ),
//                     );
//                   }

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return TripPage();
//                       },
//                     ),
//                   );
//                 },
//                 icon: Icon(
//                   Icons.done_sharp,
//                   color: Colors.green,
//                 ),
//                 label: Text(
//                   "Done",
//                   style: TextStyle(fontSize: 30, color: Colors.green),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }

//   String getBase64RandomString(int length) {
//     var random = Random.secure();
//     var values = List<int>.generate(length, (i) => random.nextInt(255));
//     return base64UrlEncode(values);
//   }
// }
