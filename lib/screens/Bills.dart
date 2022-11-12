import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  TextEditingController bill_name = TextEditingController();
  TextEditingController amount = TextEditingController();
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
                  borderSide: BorderSide(color: Colors.green),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                icon: Icon(
                  Icons.trip_origin_rounded,
                  color: Colors.green,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                fillColor: Colors.white,
                label: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Bill Name",
                    style: TextStyle(color: Colors.green),
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
                  borderSide: BorderSide(color: Colors.green),
                ),
                icon: Icon(
                  Icons.people,
                  color: Colors.green,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                fillColor: Colors.white,
                label: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Amount",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  FirebaseFirestore db = FirebaseFirestore.instance;

                  Map<String, dynamic> userInfo = {
                    "billName": bill_name.text,
                    "amount": amount.text
                  };
                  db.collection("Bills").add(userInfo).then(
                      (DocumentReference doc) =>
                          print('DocumentSnapshot added with ID: ${doc.id}'));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Bill Added succecfully")));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Try again!")));
                }
              },
              child: Text("Upload"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
