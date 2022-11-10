import 'package:flutter/material.dart';

import '../../screens/Bills.dart';
import '../../screens/Participants.dart';
import '../../screens/TripDeatails.dart';
import '../../screens/UploedImage.dart';
import '../services.dart';
import 'catagoryCard.dart';

List pages = [
  TripDetails(),
  Participants(),
  Uplode_screen(),
  Bills(),
];

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key});

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              pageName: "h",
            ));
  }
}
