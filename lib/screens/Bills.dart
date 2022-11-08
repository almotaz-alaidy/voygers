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
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context, "trip_page"),
            icon: Icon(
              Icons.app_registration,
              color: Color.fromARGB(255, 9, 9, 9),
            ),
          )
        ],
      ),
      body: Container(
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: bill_name,
              decoration: InputDecoration(
                  hintText: 'Bill name',
                  icon: Icon(Icons.trip_origin_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: Colors.white),
            ),
            TextField(
              controller: amount,
              decoration: InputDecoration(
                  hintText: 'Amount',
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: Colors.white),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            )
          ],
        ),
      ),
    );
  }
}
