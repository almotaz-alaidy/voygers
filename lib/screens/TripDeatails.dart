import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
          style: GoogleFonts.aclonica(
              textStyle: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
        ),
        backgroundColor: primary_color,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context, "trip_page"),
            icon: Lottie.asset("images/panda.json"),
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
                            " ${snapshot.data!.get("tripName")}",
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 35,
                              color: primary_color,
                              fontWeight: FontWeight.bold,
                            )),
                          )),
                          Lottie.asset("images/panda.json",
                              width: 100, height: 100),
                          Center(
                              child: Text(
                            "trip capacity: ${snapshot.data!.get("cap")}",
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: primary_color,
                              fontWeight: FontWeight.bold,
                            )),
                          )),
                          Center(
                              child: Text(
                            "trip cost: ${snapshot.data!.get("cost")} JD",
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: primary_color,
                              fontWeight: FontWeight.bold,
                            )),
                          )),
                          Center(
                              child: Text(
                            "trip discripition: ${snapshot.data!.get("disc")}",
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: primary_color,
                              fontWeight: FontWeight.bold,
                            )),
                          )),
                          Center(
                              child: Text(
                            "allowed female?  ${snapshot.data!.get("only females")}",
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: primary_color,
                              fontWeight: FontWeight.bold,
                            )),
                          )),
                          Center(
                              child: Text(
                            " privacy  ${snapshot.data!.get("privacy")}",
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: primary_color,
                              fontWeight: FontWeight.bold,
                            )),
                          )),
                          Center(
                              child: Text(
                            "trip date: ${snapshot.data!.get("date")}",
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: primary_color,
                              fontWeight: FontWeight.bold,
                            )),
                          )),
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                              child: Image.network(
                                  "${snapshot.data!.get("adsImage")}")),
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
