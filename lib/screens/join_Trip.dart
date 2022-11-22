import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voygares/compononet/colors.dart';
import 'package:voygares/compononet/customtextfeild.dart';
import 'package:voygares/screens/TripCreate.dart';

import 'bottom_appbar.dart';

class JoinTrip extends StatefulWidget {
  const JoinTrip({super.key});

  @override
  State<JoinTrip> createState() => _JoinTripState();
}

class _JoinTripState extends State<JoinTrip> {
  TextEditingController _code = TextEditingController();
  String? logic;
  String? joinUser;
  String? myTripId;
  // _______________________________participants______________________________________________________________________

  CollectionReference userRef1 = FirebaseFirestore.instance.collection("users");
  CollectionReference partRef =
      FirebaseFirestore.instance.collection("participants");

  String? partDocument;

  // _________________________________________________get the document in participant ___________________________

  GetTipId() {
    partRef.where("trip_id", isEqualTo: myTripId).get().then(
        (QuerySnapshot snapshot) =>
            snapshot.docs.forEach((DocumentSnapshot doc) {
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

              partDocument = doc.id.toString();
              print(partDocument);
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            }));
  }

  // ______________________________emal and name of current user to put it inside the list _____________________________
  String? theNme;
  String? theEmail;

  GetNameEmail() {
    userRef1
        .where("uid", isEqualTo: myUser.currentUser!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              theNme = element["Name"];
              theEmail = element["Email"];
            }));
  }

  // ___________________________________________________________________________________________________________________________

  Test() {
    FirebaseFirestore.instance
        .collection("code")
        .where(
          "code",
        )
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) async {
              element["trip_id"].toString();
              myTripId = element["trip_id"].toString();
              print(myTripId);

              CollectionReference userRef =
                  FirebaseFirestore.instance.collection("users");
              userRef
                  .where("uid", isEqualTo: myUser.currentUser!.uid)
                  .get()
                  .then(
                (QuerySnapshot snapshot) {
                  snapshot.docs.forEach(
                    (DocumentSnapshot doc) {
                      joinUser = doc.id;
                    },
                  );
                },
              );
            },
          ),
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    Test();
    GetNameEmail();
    GetTipId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        title: Text(
          "joining the trip ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/jointrip.gif"))),
            ),
            customTextfeild(controller: _code, text: "Enter Your code"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  FirebaseFirestore.instance
                      .collection("code")
                      .where(
                        "code",
                      )
                      .get()
                      .then((value) => value.docs.forEach((element) async {
                            if (_code.text == element["code"].toString()) {
                              element["trip_id"].toString();
                              myTripId = element["trip_id"].toString();
                              GetTipId();
                              GetNameEmail();

                              CollectionReference userRef = FirebaseFirestore
                                  .instance
                                  .collection("users");
                              userRef
                                  .where("uid",
                                      isEqualTo: myUser.currentUser!.uid)
                                  .get()
                                  .then((QuerySnapshot snapshot) {
                                snapshot.docs.forEach((DocumentSnapshot doc) {
                                  joinUser = doc.id;
                                });
                              });
                              CollectionReference db3 = await FirebaseFirestore
                                  .instance
                                  .collection("users");
                              Map<String, dynamic> mytripdoc = {
                                "trip_id": myTripId,
                                "creator": "0",
                              };

                              db3.doc(joinUser).update(mytripdoc);

                              // ____________________________________________participants_____________________________________________

                              Map participantName = {"name": theNme};
                              Map participantEmail = {"email": theEmail};

                              CollectionReference parti = FirebaseFirestore
                                  .instance
                                  .collection("participants");

                              Map<String, dynamic> PartiField = await {
                                "Name": participantName,
                                "Email": participantEmail,
                                "trip_id": myTripId,
                              };

                              await parti.add(PartiField);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TripPage(),
                                  ));
                            }
                          }));
                } catch (e) {}
              },
              child: Text("Join"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary_color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
