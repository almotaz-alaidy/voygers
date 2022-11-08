import 'dart:math';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'TripPage.dart';

class GenerateCode extends StatefulWidget {
  const GenerateCode({super.key});

  @override
  State<GenerateCode> createState() => _GenerateCodeState();
}

class _GenerateCodeState extends State<GenerateCode> {
  String generated_code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 245, 153, 183),
          title: Text(
            "LET THE FUN SATRT",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: Colors.purple,
              fontSize: 25,
            ),
          ),
        ),
        // drawer: Drawer(
        // backgroundColor: Color.fromARGB(255, 247, 145, 179),
        // child: TextButton.icon(
        //   onPressed: () {
        // setState(() {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return MainPage();
        //   }));
        // });
        //     },
        //     icon: Icon(
        //       Icons.exit_to_app,
        //       color: Colors.purple,
        //     ),
        //     label: Text(
        //       "Back",
        //       style: TextStyle(color: Color.fromARGB(255, 245, 206, 252)),
        //     ),
        //   ),
        // ),
        body: Container(
          width: 600,
          // decoration: BoxDecoration(
          //     gradient: SweepGradient(colors: [
          //   Color.fromARGB(255, 162, 0, 187),
          //   Color.fromARGB(255, 230, 141, 171),
          //   Colors.purple,
          //   Color.fromARGB(255, 230, 141, 171),
          //   Color.fromARGB(255, 167, 0, 193),
          // ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                generated_code,
                style: TextStyle(backgroundColor: Colors.white, fontSize: 30),
              ),
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      generated_code = getBase64RandomString(8);
                    });
                  },
                  icon: Icon(
                    Icons.generating_tokens,
                    // color: Colors.purple,
                  ),
                  label: Text(
                    "Generate",
                    style: TextStyle(fontSize: 50),
                  )),
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      Clipboard.setData(ClipboardData(text: generated_code));
                    });
                  },
                  icon: Icon(
                    Icons.copy,
                    // color: Colors.purple,
                  ),
                  label: Text(
                    "copy",
                    style: TextStyle(fontSize: 50),
                  )),
              TextButton.icon(
                  onPressed: () async {
                    try {
                      FirebaseFirestore db = FirebaseFirestore.instance;

                      Map<String, dynamic> userInfo = {"code": generated_code};
                      db.collection("code").add(userInfo).then(
                          (DocumentReference doc) => print(
                              'DocumentSnapshot added with ID: ${doc.id}'));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Code Generated")));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Try again!")));
                    }

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TripPage();
                    }));
                  },
                  icon: Icon(
                    Icons.done_sharp,
                    color: Colors.purple,
                  ),
                  label: Text(
                    "Done",
                    style: TextStyle(fontSize: 30),
                  ))
            ],
          ),
        ));
  }

  String getBase64RandomString(int length) {
    var random = Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
