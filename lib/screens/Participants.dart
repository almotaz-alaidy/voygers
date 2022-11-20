import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'TripCreate.dart';

class Participants extends StatefulWidget {
  const Participants({super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  CollectionReference usersInTrip =
      FirebaseFirestore.instance.collection("participants");
  dynamic mm;

  // ___________get trip-id of current user ____________________________________
  String? userTripId;
  GetCurrentTripid() {
    // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: currentUser.currentUser!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              userTripId = element["trip_id"].toString();
              print("value of current user trip-id variable: $userTripId");
            }));
    // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    FirebaseFirestore.instance
        .collection("participants")
        .where("trip_id", isEqualTo: userTripId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element["trip_id"].toString() == userTripId) {
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

          mm = element["info"].toString();
          print(mm);
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        } else
          print("sss");
      });
    });
  }

  // ________________________________________________________________________________
  // GetTripidFromPar() {
  //   FirebaseFirestore.instance
  //       .collection("participants")
  //       .where("trip_id", isEqualTo: userTripId)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       if (element["trip_id"].toString() == userTripId) {
  //         print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

  //         print(" ddddd  ${element["info"].toString()}");
  //         print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  //       } else
  //         print("sss");
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    GetCurrentTripid();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "voygers",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context, "trip_page"),
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Text("${[mm].toString()}"),
        // child: Padding(
        //     padding: const EdgeInsets.only(top: 50),
        //     child: FutureBuilder<QuerySnapshot>(
        //       builder: (context, snapshot) {
        //         return Container(
        //             child: ListView.builder(
        //           itemCount: snapshot.data!.docs.length,
        //           itemBuilder: (context, i) {
        //             return ListView(
        //               shrinkWrap: true,
        //               physics: NeverScrollableScrollPhysics(),
        //               children: [
        //                 Text("$mm"),
        // Center(
        //   child: Center(
        //       child: Text(
        //           "${snapshot.data!.docs[i]['info'].toString()}")),
        // ),
        //       ],
        //     );
        //   },
        // ));
        // },
        // future: usersInTrip.get().then((value) => mm)
        // )

        //  usersInTrip.get().then((value) {
        //   value.docs.forEach((element) {
        //     if (element["trip_id"].toString() == userTripId) {
        //       print(
        //           "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

        //       print(" ddddd  ${element["info"].toString()}");
        //       print(
        //           "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        //     } else
        //       print("sss");
        //   });
        // })),
      ),
    );
  }
}
