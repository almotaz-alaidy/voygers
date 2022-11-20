import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../screens/Bills.dart';
import '../../screens/Participants.dart';
import '../../screens/TripCreate.dart';
import '../../screens/TripDeatails.dart';
import '../../screens/UploedImage.dart';
import '../services.dart';
import 'catagoryCard.dart';

String? userTripId;

List pages = [
  TripDetails(),
  Participants(),
  Uplode_screen(),
  Bills(),
];

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key});
  GetCurrentTripid() {
    FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: currentUser.currentUser!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              userTripId = element["trip_id"].toString();
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
              print("value of current user trip-id variable: $userTripId");
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.85),
        itemBuilder: (context, index) => CategoryCard(
              product: products[index],
              onmyTap: () {
                GetCurrentTripid();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              pageName: "h",
            ));
  }
}
