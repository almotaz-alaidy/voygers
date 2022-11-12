import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voygares/compononet/show_dialog.dart';
import 'package:voygares/screens/structure.dart';
import 'package:voygares/wedget/regulartextfeid.dart';

import '../compononet/ads.dart';
import 'GenerateCode.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  DateTime _date = DateTime(2023, 1, 1);
  bool _public = false;
  bool only_females = false;
  File? image;
  Future _pickImage1() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController trip_name = TextEditingController();
  TextEditingController trip_capacity = TextEditingController();
  TextEditingController trip_cost = TextEditingController();
  TextEditingController trip_disc = TextEditingController();
  TextEditingController trip_tools = TextEditingController();
  TextEditingController needed_tools = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Trip"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(
              context,
            ),
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  RegularTextFeild(
                      hintText: "Trip Name",
                      myAssetImage: "images/trip name.png",
                      myController: trip_name,
                      myLabel: "Trip Name",
                      myMaxLine: 1),
                  SizedBox(
                    height: 20,
                  ),
                  RegularTextFeild(
                      hintText: "Capacity",
                      myAssetImage: "images/capacity.png",
                      myController: trip_capacity,
                      myLabel: "Capacity",
                      myMaxLine: 1),
                  SizedBox(
                    height: 20,
                  ),
                  RegularTextFeild(
                      hintText: "Cost/JOD",
                      myAssetImage: "images/money-bag.png",
                      myController: trip_cost,
                      myLabel: "Cost/JOD",
                      myMaxLine: 1),
                  SizedBox(
                    height: 20,
                  ),
                  RegularTextFeild(
                      hintText: "Discription",
                      myAssetImage: "images/dis.png",
                      myController: trip_disc,
                      myLabel: "Discription",
                      myMaxLine: 7),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              trailing: Image(
                image: AssetImage("images/public-relations.png"),
                color: Colors.green,
                height: 25,
                width: 25,
              ),
              title: Text("Show trip"),
              subtitle: Text("Public / Private"),
              leading: Switch(
                  activeColor: Colors.green,
                  value: _public,
                  onChanged: ((value) {
                    setState(() {
                      _public = value;
                    });
                  })),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              trailing: Image(
                color: Colors.green,
                image: AssetImage("images/female only.png"),
                height: 25,
                width: 25,
              ),
              title: Text("Gender Allowed"),
              subtitle: Text("Females only"),
              leading: Switch(
                  activeColor: Colors.green,
                  value: only_females,
                  onChanged: ((value) {
                    setState(() {
                      only_females = value;
                    });
                  })),
            ),
            ListTile(
              title: Text("Upload Image"),
              subtitle: Text("choose image to make your ADS putty"),
              trailing: IconButton(
                icon: image != null
                    ? Image.file(
                        image!,
                        width: 200,
                        height: 200,
                      )
                    : Image.asset(
                        "images/upload.png",
                        color: Colors.green,
                      ),
                onPressed: () {
                  setState(() {
                    _pickImage1();
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Trip Date"),
              subtitle: Text(_date.toString()),
              trailing: IconButton(
                icon: Image.asset(
                  "images/celender.png",
                  color: Colors.green,
                  width: 30,
                  height: 30,
                ),
                onPressed: () async {
                  DateTime? new_date = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2023, 1, 1),
                      lastDate: DateTime(2050));
                  if (new_date == null) {
                    return;
                  }
                  setState(() {
                    _date = new_date;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "images/location.png",
                    color: Colors.green,
                    width: 30,
                    height: 30,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Needed tools for the trip'),
                                content: Container(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    // int.parse(trip_tools.text),
                                    itemBuilder: ((context, index) {
                                      List tools1 = [];
                                      return Column(
                                        children: [
                                          TextField(
                                            controller: needed_tools,
                                            decoration: InputDecoration(
                                                hintText: 'Tool'),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  tools1.add(needed_tools.text);
                                                  needed_tools.clear();
                                                });
                                              },
                                              child: Text("Upload")),
                                          ElevatedButton(
                                              onPressed: () {
                                                try {
                                                  FirebaseFirestore db =
                                                      FirebaseFirestore
                                                          .instance;

                                                  Map<String, dynamic> tools = {
                                                    "tool": tools1,
                                                  };

                                                  db
                                                      .collection(
                                                          "tools per trip")
                                                      .add(tools)
                                                      .then((DocumentReference
                                                              doc) =>
                                                          print(
                                                              'DocumentSnapshot added with ID: ${doc.id}'));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "uploaded")));
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Try again!")));
                                                }
                                              },
                                              child: Text("Done"))
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              );
                            });
                      });
                    },
                    icon: Image.asset(
                      "images/tools.png",
                      color: Colors.green,
                      width: 30,
                      height: 30,
                    )),
                ElevatedButton(
                  onPressed: () {
                    try {
                      FirebaseFirestore db = FirebaseFirestore.instance;

                      Map<String, dynamic> trip_info = {
                        "tripName": trip_name.text,
                        "cap": trip_capacity.text,
                        "cost": trip_cost.text,
                        "disc": trip_disc.text,
                        "privacy": _public.toString(),
                        "date": _date.toString(),
                        "only females": only_females.toString()
                      };

                      db.collection("trips").add(trip_info).then(
                          (DocumentReference doc) => print(
                              'DocumentSnapshot added with ID: ${doc.id}'));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("trip created succecfully")));
                      showDialog(
                        context: context,
                        builder: (context) {
                          return GenerateMyCode(generated_code: "");
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Try again!")));
                    }
                  },
                  child: Text("Generate Code"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
