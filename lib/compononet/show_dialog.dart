import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voygares/screens/bottom_appbar.dart';

class GenerateMyCode extends StatefulWidget {
  GenerateMyCode({required this.generated_code});
  String generated_code = "";
  @override
  State<GenerateMyCode> createState() => _GenerateMyCodeState();
}

class _GenerateMyCodeState extends State<GenerateMyCode> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.bus_alert),
      title: Text(
        "Generate Your code ",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      backgroundColor: Colors.green,
      content: Container(
        decoration: BoxDecoration(),
        width: 300,
        height: 200,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 33,
                ),
                Text(
                  widget.generated_code,
                  style: TextStyle(backgroundColor: Colors.white, fontSize: 22),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        Clipboard.setData(
                          ClipboardData(
                            text: widget.generated_code,
                          ),
                        );
                      });
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Colors.white,
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    widget.generated_code = getBase64RandomString(8);
                  });
                },
                icon: Icon(
                  Icons.generating_tokens,
                  color: Colors.green,
                ),
                label: Text(
                  "Code",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                )),
            TextButton.icon(
              onPressed: () async {
                try {
                  FirebaseFirestore db = FirebaseFirestore.instance;

                  Map<String, dynamic> userInfo = {
                    "code": widget.generated_code
                  };
                  db.collection("code").add(userInfo).then(
                        (DocumentReference doc) =>
                            print('DocumentSnapshot added with ID: ${doc.id}'),
                      );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Code Generated")));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Try again!"),
                    ),
                  );
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TripPage();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.done_sharp,
                color: Colors.green,
              ),
              label: Text(
                "Done",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getBase64RandomString(int length) {
    var random = Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
