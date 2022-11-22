import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voygares/compononet/colors.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

String? oldTrip;
FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference UsersRef = FirebaseFirestore.instance.collection("users");

class _HistoryState extends State<History> {
  GetOldTripValue() {
    UsersRef.where("uid", isEqualTo: auth.currentUser!.uid).get().then((value) {
      value.docs.forEach((element) {
        oldTrip = element["old_trip"];
        print("@@@@@@@@@@@@@@@@@@@@@@@");
        print("the value of current user trip id is :   $oldTrip");
        print("@@@@@@@@@@@@@@@@@@@@@@@");
      });
    });
  }

  // ________________________________________________________________________
  late DocumentReference oldTripDetails =
      FirebaseFirestore.instance.collection("trips").doc("${oldTrip}");

  @override
  void initState() {
    // TODO: implement initState
    GetOldTripValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Trip log",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: primary_color,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context, "trip_page"),
            icon: Icon(
              Icons.app_registration,
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: FutureBuilder<DocumentSnapshot>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      child: ListView.builder(
                    // itemCount: snapshot.data!.docs.length,
                    itemCount: 1,
                    itemBuilder: (context, i) {
                      return ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Center(
                              child: Text(
                                  "trip name: ${snapshot.data!.get("tripName")}")),
                          // Center(
                          //     child: Image.network(
                          //         "${snapshot.data!.get("adsImage")}")),
                          // Center(
                          //     child: Text(
                          //         "trip capacity: ${snapshot.data!.get("cap")}")),
                          // Center(
                          //     child: Text(
                          //         "trip cost: ${snapshot.data!.get("cost")}")),
                          // Center(
                          //     child: Text(
                          //         "trip discripition: ${snapshot.data!.get("disc")}")),
                          // Center(
                          //     child: Text(
                          //         "allowed female?  ${snapshot.data!.get("only females")}")),
                          // Center(
                          //     child: Text(
                          //         " privacy  ${snapshot.data!.get("privacy")}")),
                          // Center(
                          //     child: Text(
                          //         "trip date: ${snapshot.data!.get("date")}")),
                        ],
                      );
                    },
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text("");
                }
              },
              future: oldTripDetails.get()),
        ),
      ),
    );
  }
}
