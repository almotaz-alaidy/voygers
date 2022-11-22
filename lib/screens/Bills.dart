import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voygares/compononet/colors.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  TextEditingController bill_name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController _persons = TextEditingController();

  // ____________________________get the trip_id of the current user _________________________________________________
  CollectionReference userTripId =
      FirebaseFirestore.instance.collection("users");
  FirebaseAuth auth = FirebaseAuth.instance;
  String? currentTripId;
  GetTripId() {
    userTripId
        .where("uid", isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        currentTripId = element["trip_id"];
        print("@@@@@@@@@@@@@@@@@@@@@@@");
        print(currentTripId);
        print("@@@@@@@@@@@@@@@@@@@@@@@");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    GetTripId();
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
          elevation: 0,
          backgroundColor: primary_color,
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pop(context, "trip_page"),
                icon: Lottie.asset("images/panda.json"))
          ],
        ),
        body: Stack(
          children: [
            Image(
              image: AssetImage("images/food.png"),
              color: primary_color,
            ),
            Container(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: bill_name,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      icon: Icon(
                        Icons.trip_origin_rounded,
                        color: primary_color,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      fillColor: Colors.white,
                      label: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "Bill Name",
                          style: TextStyle(color: primary_color),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: amount,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      icon: Icon(
                        Icons.price_change,
                        color: primary_color,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      fillColor: Colors.white,
                      label: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "Amount",
                          style: TextStyle(color: primary_color),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _persons,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      icon: Icon(
                        Icons.people,
                        color: primary_color,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      fillColor: Colors.white,
                      label: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "persons",
                          style: TextStyle(color: primary_color),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        FirebaseFirestore db = FirebaseFirestore.instance;

                        Map<String, dynamic> billsInfo = {
                          "billName": bill_name.text,
                          "amount": amount.text,
                          "persons": _persons.text,
                          "trip_id": currentTripId,
                        };
                        db.collection("Bills").add(billsInfo).then(
                            (DocumentReference doc) => print(
                                'DocumentSnapshot added with ID: ${doc.id}'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Bill Added succecfully")));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Try again!")));
                      }
                    },
                    child: Text("Upload"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary_color.withOpacity(1)),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
