import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  // _______________________________________________________________________________________
  late DocumentReference tripDetails =
      FirebaseFirestore.instance.collection("trips").doc("${userField}");
  // __________________________________________________________________________________________
  // CollectionReference UsersRef = FirebaseFirestore.instance.collection("users");
  // String? userField;
  // FirebaseAuth auth = FirebaseAuth.instance;

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
          child: FutureBuilder<DocumentSnapshot>(
              builder: (context, snapshot) {
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
              },
              future: tripDetails.get()),
          // child: StreamBuilder<QuerySnapshot>(
          //   stream: tripDetails.get(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     if (snapshot.hasData) {
          //       return ListView.separated(
          //         separatorBuilder: (context, index) {
          //           return Divider(
          //             height: 20,
          //           );
          //         },
          //         itemCount: snapshot.data!.docs.length,
          //         itemBuilder: (context, index) {
          //           QueryDocumentSnapshot x = snapshot.data!.docs[index];
          //           return Container(
          //             child: Column(children: [
          //               Text(
          //                 ('name of the trip :'),
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text(
          //                 (x['tripName']),
          //                 style: TextStyle(
          //                     fontSize: 20, fontWeight: FontWeight.bold),
          //               ),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text(
          //                 ('capacity :'),
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text(
          //                 (x['cap']),
          //                 style: TextStyle(
          //                     fontSize: 20, fontWeight: FontWeight.bold),
          //               ),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text(
          //                 ('cost  :'),
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                 ),
          //               ),
          //               Text(
          //                 (x['cost']),
          //                 style: TextStyle(
          //                     fontSize: 20, fontWeight: FontWeight.bold),
          //               ),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text(
          //                 ('discription  :'),
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text(
          //                 (x['disc']),
          //                 style: TextStyle(
          //                     fontSize: 20, fontWeight: FontWeight.bold),
          //               ),
          //             ]),
          //           );
          //         },
          //       );
          //     }
          //     return Center(
          //       child: Container(),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
