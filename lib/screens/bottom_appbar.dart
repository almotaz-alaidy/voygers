import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voygares/screens/home_screen.dart';
import 'package:voygares/screens/share.dart';

import '../utils/binding/HomeBinding.dart';
import 'structure.dart';
import 'mtProfile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

String? logic1;

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  // *@dfas
  List page = [
    StructureScreen(),
    Profile(),
    ShareCode(),
  ];
  int _selectedPage = 0;
  final currentUser = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child: page[_selectedPage],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          const TabItem(icon: Icons.home, title: 'Home'),
          const TabItem(icon: Icons.people, title: 'profile'),
          const TabItem(icon: Icons.share, title: 'share'),
          // const TabItem(icon: Icons.person, title: 'wether'),
        ],
        backgroundColor: Colors.green,
        activeColor: Color.fromARGB(255, 247, 249, 247),
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

            FirebaseFirestore.instance
                .collection("users")
                .where("uid", isEqualTo: currentUser.currentUser!.uid)
                .get()
                .then((value) => value.docs.forEach((element) {
                      print(element["trip_id"].toString());
                      logic1 = element["trip_id"].toString();
                    }));
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

            print("value of logic variable: $logic1");
            _selectedPage = i;
          });
        },
      ),
    );
  }
}
