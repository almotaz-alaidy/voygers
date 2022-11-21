import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // child: Text("${[mm].toString()}"),
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
                          child: DrawerHeader(
                        child: Column(children: [
                          Text(x['participants name '].toString()),
                          Text(x['participants emails'].toString()),
                        ]),
                      ));
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
