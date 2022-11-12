import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Participants extends StatefulWidget {
  const Participants({super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  CollectionReference usersInTrip =
      FirebaseFirestore.instance.collection("users");
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
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: StreamBuilder<QuerySnapshot>(
            stream: usersInTrip.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 20,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[index];
                    return Container(
                      child: Column(children: [
                        Text(
                          ('name of the participant :'),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          (x['Name']),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          ('email  of the participant :'),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          (x['Email']),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    );
                  },
                );
              }
              return Center(
                child: Container(),
              );
            },
          ),
        ),
      ),
    );
  }
}
