import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:voygares/compononet/colors.dart';

import '../compononet/catagory/catagoryList.dart';

// ignore: must_be_immutable
class Advice extends StatefulWidget {
  Advice({required this.i});
  int i = 0;

  @override
  State<Advice> createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: primary_color,
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
            ],
          ),
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Center(
        // child: FittedBox(
        //   child: Text(
        //     "ssssss ${[widget.i]}",
        //     style: GoogleFonts.amiri(
        //       textStyle: const TextStyle(
        //         fontSize: 30.0,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white,
        //       ),
        //     ),
        //     maxLines: 1,
        //   ),
        // ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("comments")
              .where("trip_id", isEqualTo: userTripId)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot x = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Text("ss"),
                      FittedBox(
                        child: Text(
                          "${x['subject']}",
                          style: GoogleFonts.amiri(
                            textStyle: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                },
              );

              // FittedBox(
              //   child: Text(
              //     "${advices[widget.i]}",
              //     style: GoogleFonts.amiri(
              //       textStyle: const TextStyle(
              //         fontSize: 30.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //     maxLines: 1,
              //   ),
              // );

              // ListView.builder(
              //   itemCount: snapshot.data!.docs.length,
              //   itemBuilder: (context, index) {
              //     QueryDocumentSnapshot x = snapshot.data!.docs[index];
              //     return Container(
              //         child: DrawerHeader(
              //       child: Column(children: [
              //         Text(x['participants name '].toString()),
              //         Text(x['participants emails'].toString()),
              //       ]),
              //     ));
              //   },
              // );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
