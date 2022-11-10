import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:voygares/screens/share.dart';

import 'structure.dart';
import 'mtProfile.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  // *@dfas
  List page = [StructureScreen(), Profile(), Share()];
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom bar
      // now we will use bottom bar package

      body: page[_selectedPage],
      bottomNavigationBar: ConvexAppBar(
        items: [
          const TabItem(icon: Icons.home, title: 'Home'),
          const TabItem(icon: Icons.people, title: 'profile'),
          const TabItem(icon: Icons.share, title: 'share')
        ],
        backgroundColor: Colors.green,
        activeColor: Color.fromARGB(255, 247, 249, 247),
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            _selectedPage = i;
          });
        },
      ),
    );
  }
}
