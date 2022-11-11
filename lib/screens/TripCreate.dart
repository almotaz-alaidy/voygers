import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip/screens/ads.dart';

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
        appBar: AppBar(title: Text("Create Trip")),
        body: ListView(
          children: [
            Column(
              children: [
                TextField(
                  controller: trip_name,
                  decoration: InputDecoration(hintText: "Trip Name"),
                ),
                TextField(
                  controller: trip_capacity,
                  decoration: InputDecoration(hintText: "Capacity"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: trip_cost,
                  decoration: InputDecoration(hintText: "Cost/JOD"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: trip_disc,
                  decoration: InputDecoration(hintText: "Discription"),
                  autocorrect: true,
                  maxLines: 7,
                ),
                ListTile(
                  title: Text("Show trip"),
                  subtitle: Text("Public / Private"),
                  trailing: Switch(
                      value: _public,
                      onChanged: ((value) {
                        setState(() {
                          _public = value;
                        });
                      })),
                ),
                ListTile(
                  title: Text("Gender Allowed"),
                  subtitle: Text("Females only"),
                  trailing: Switch(
                      value: only_females,
                      onChanged: ((value) {
                        setState(() {
                          only_females = value;
                        });
                      })),
                ),
                ListTile(
                  title: Text("Upload Image"),
                  subtitle: Text("You can Keep our Example image"),
                  trailing: IconButton(
                    icon: image != null
                        ? Image.file(
                            image!,
                            width: 200,
                            height: 200,
                          )
                        : Image.network(
                            "https://cdn-icons-png.flaticon.com/512/2914/2914180.png",
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
                    icon: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/591/591616.png"),
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
                        icon: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/854/854878.png")),
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
                                                      tools1.add(
                                                          needed_tools.text);
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

                                                      Map<String, dynamic>
                                                          tools = {
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
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "uploaded")));
                                                    } catch (e) {
                                                      ScaffoldMessenger.of(
                                                              context)
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
                        icon: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/2081/2081762.png")),
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("trip created succecfully")));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Try again!")));
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Ads();
                        }));
                      },
                      child: Text("Generate Code"),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
