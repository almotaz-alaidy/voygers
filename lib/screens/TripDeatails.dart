import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voygares/compononet/colors.dart';
import 'login_screen.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late DocumentReference tripDetails =
      FirebaseFirestore.instance.collection("trips").doc("${userField}");

  readFeildFromUsers() {
    UsersRef.where("uid", isEqualTo: auth.currentUser!.uid).get().then((value) {
      value.docs.forEach((element) {
        userField = element["trip_id"];
        print("@@@@@@@@@@@@@@@@@@@@@@@");
        print(userField);
        print("@@@@@@@@@@@@@@@@@@@@@@@");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readFeildFromUsers();
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
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
                          Center(
                              child: Image.network(
                                  "${snapshot.data!.get("adsImage")}")),
                          Center(
                              child: Text(
                                  "trip capacity: ${snapshot.data!.get("cap")}")),
                          Center(
                              child: Text(
                                  "trip cost: ${snapshot.data!.get("cost")}")),
                          Center(
                              child: Text(
                                  "trip discripition: ${snapshot.data!.get("disc")}")),
                          Center(
                              child: Text(
                                  "allowed female?  ${snapshot.data!.get("only females")}")),
                          Center(
                              child: Text(
                                  " privacy  ${snapshot.data!.get("privacy")}")),
                          Center(
                              child: Text(
                                  "trip date: ${snapshot.data!.get("date")}")),
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
                  return Text("ssssssss");
                }
              },
              future: tripDetails.get()),
        ),
      ),
    );
  }
}
