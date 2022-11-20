// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   FirebaseAuth myUser = FirebaseAuth.instance;
//   String? userDocName;
//   List info = [];
//   dynamic name;
//   String? email;

//   Test() {
//     CollectionReference userRef1 =
//         FirebaseFirestore.instance.collection("users");
//     userRef1
//         .where("uid", isEqualTo: myUser.currentUser!.uid)
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         email = element["Email"];
//         name = element["Name"];

//         print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         print(email);
//         print(name);
//         print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//       });
//     });
//     //     .then((QuerySnapshot snapshot) {
//     //   snapshot.docs.forEach((DocumentSnapshot doc) {
//     //     print(doc.id);
//     //     userDocName = doc.id;
//     //     print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//     //     print(userDocName);
//     //     print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//     //   });
//     // });
//   }

//   late Map<String, dynamic> MM = {name: email};

//   @override
//   void initState() {
//     // TODO: implement initState
//     Test();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               print(MM);
//             },
//             child: Text("ssss")),
//       ),
//     );
//   }
// }
