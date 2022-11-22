import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:voygares/compononet/colors.dart';

import '../compononet/catagory/catagoryList.dart';

class Participants extends StatefulWidget {
  const Participants({super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  CollectionReference usersInTrip =
      FirebaseFirestore.instance.collection("participants");
  dynamic mm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "voygers",
            style: GoogleFonts.aclonica(
                textStyle: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
          ),
          elevation: 0,
          backgroundColor: primary_color,
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pop(context, "trip_page"),
                icon: Lottie.asset("images/panda.json"))
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("participants")
                  .where("trip_id", isEqualTo: userTripId)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot x = snapshot.data!.docs[index];

                      return Container(
                        color: primary_color.withOpacity(0.5),
                        child: Column(children: [
                          ListTile(
                            leading: Image(
                              image: AssetImage("images/food.png"),
                              color: primary_color,
                            ),
                            title: Text(
                              x['Name']["name"].toString(),
                              style: TextStyle(fontSize: 30),
                            ),
                            subtitle: Text(
                              x['Email']["email"].toString(),
                            ),
                          ),
                        ]),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ));
  }
}
