import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voygares/compononet/colors.dart';
import 'package:voygares/compononet/show_dialog.dart';
import 'package:voygares/screens/bottom_appbar.dart';
import 'package:voygares/screens/google_maps.dart';
import 'package:voygares/wedget/regulartextfeid.dart';
import '../model/imag.dart';
import 'package:path/path.dart';

import 'GenerateCode.dart';

FirebaseAuth myUser = FirebaseAuth.instance;
String? userDocName;
String? generated_code;
late String tripDoc;
late String docFortools;
final currentUser = FirebaseAuth.instance;

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
  UploadTask? task3;
  String? imageUrl;
  String? tripId;

  // ______________________________________________participant function __________________________________________
  String? name;
  String? email;

  GetThePar() {
    CollectionReference userRef1 =
        FirebaseFirestore.instance.collection("users");
    userRef1
        .where("uid", isEqualTo: myUser.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        name = element["Name"];
        email = element["Email"];

        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        print(email);
        print(name);
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      });
    });
  }
  // _______________________________________________________________________________________________________________________
  // ________________________________select image___________________________________________________________________________

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
  // __________________________________________________________________________________________________________________________

  TextEditingController trip_name = TextEditingController();
  TextEditingController trip_capacity = TextEditingController();
  TextEditingController trip_cost = TextEditingController();
  TextEditingController trip_disc = TextEditingController();
  TextEditingController trip_tools = TextEditingController();
  TextEditingController needed_tools = TextEditingController();

  String? uidUser;
  // _______________________________________uploed image__________________________________________
  Future uploadimage() async {
    if (image == null) return Text("no image selected");

    final imageName = basename(image!.path);
    final destination1 = 'adsImage/$imageName';

    task3 = ImageApi.uploadimage(destination1, image!);
    setState(() {});

    if (image == null) return;

    final snapshot = await task3!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // test for url______________________________________________________________________________________
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

    print('Download-Link: $urlDownload');
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    // __________________________________________________________________________________________________

    final ref =
        FirebaseStorage.instance.ref().child('adsImage').child('$imageName');
    await ref.putFile(image!);
    imageUrl = await ref.getDownloadURL();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> trip_info = {
      "tripName": "",
      "cap": "",
      "cost": "",
      "disc": "",
      "privacy": "",
      "date": "",
      "only females": "",
      "adsImage": "",
    };

    db.collection("trips").add(trip_info).then((DocumentReference doc) {
      tripDoc = doc.id.toString();
    });
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("users");
    userRef
        .where("uid", isEqualTo: myUser.currentUser!.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.id);
        userDocName = doc.id;
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        print(userDocName);
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      });
    });
    GetThePar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Trip"),
        backgroundColor: primary_color,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "main_page");
            },
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
              leading: Image(
                image: AssetImage("images/public-relations.png"),
                color: primary_color,
                height: 25,
                width: 25,
              ),
              title: Text("Show trip"),
              subtitle: Text("Public / Private"),
              trailing: Switch(
                  activeColor: primary_color,
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
              leading: Image(
                color: primary_color,
                image: AssetImage("images/female only.png"),
                height: 25,
                width: 25,
              ),
              title: Text("Gender Allowed"),
              subtitle: Text("Females only"),
              trailing: Switch(
                  activeColor: primary_color,
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
                trailing: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: primary_color,
                            content: Row(
                              children: [
                                TextButton.icon(
                                  label: Text(
                                    "select",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: image != null
                                      ? Image.file(
                                          image!,
                                          width: 50,
                                          height: 50,
                                        )
                                      : Image.asset(
                                          "images/upload.png",
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                        ),
                                  onPressed: () {
                                    _pickImage1();
                                  },
                                ),
                                TextButton.icon(
                                    label: Text(
                                      "uploed",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      uploadimage();
                                    },
                                    icon: Icon(
                                      Icons.install_mobile_sharp,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text("image"))),
            ListTile(
              title: Text("Trip Date"),
              subtitle: Text(_date.toString()),
              trailing: IconButton(
                icon: Image.asset(
                  "images/celender.png",
                  color: primary_color,
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Google_Maps(),
                        ));
                  },
                  icon: Image.asset(
                    "images/location.png",
                    color: primary_color,
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
                                backgroundColor: primary_color,
                                title: Image.asset(
                                  "images/tools.png",
                                  width: 30,
                                  height: 30,
                                ),
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
                                              child: Text(
                                                "Upload",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )),
                                          TextButton(
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
                                                          doc) {
                                                    docFortools =
                                                        doc.id.toString();
                                                    print(
                                                        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                                                    print(docFortools);
                                                    print(
                                                        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                                                  });
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
                                              child: Text(
                                                "Done",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30),
                                              ))
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
                      color: primary_color,
                      width: 30,
                      height: 30,
                    )),
                ElevatedButton(
                  onPressed: () async {
                    generated_code = getBase64RandomString(8);
                    try {
                      CollectionReference tripUdate =
                          FirebaseFirestore.instance.collection("trips");

                      Map<String, dynamic> trip_info = {
                        "tripName": trip_name.text,
                        "cap": trip_capacity.text,
                        "cost": trip_cost.text,
                        "disc": trip_disc.text,
                        "privacy": _public.toString(),
                        "date": _date.toString(),
                        "only females": only_females.toString(),
                        "adsImage": imageUrl.toString(),
                        "generated code": generated_code.toString(),
                      };

                      // _____________________________________________update trip collection _________________________________________
                      CollectionReference userRef =
                          FirebaseFirestore.instance.collection("users");
                      userRef
                          .where("uid", isEqualTo: myUser.currentUser!.uid)
                          .get()
                          .then((QuerySnapshot snapshot) {
                        snapshot.docs.forEach((DocumentSnapshot doc) {
                          print(doc.id);
                          userDocName = doc.id;
                          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                          print(userDocName);
                          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                        });
                      });

                      tripUdate.doc(tripDoc).update(trip_info);
                      // _________________________________________________________________________________________________

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("trip created succecfully")));
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: primary_color,
                            content: Container(
                              width: 200,
                              height: 200,
                              child: Column(children: [
                                Text(
                                  generated_code!,
                                  style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontSize: 30),
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      setState(
                                        () {
                                          Clipboard.setData(
                                            ClipboardData(text: generated_code),
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "copy",
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    )),
                                TextButton.icon(
                                  onPressed: () async {
                                    FirebaseFirestore db =
                                        FirebaseFirestore.instance;

                                    Map<String, dynamic> userInfo = {
                                      "code": generated_code,
                                      "trip_id": tripDoc
                                    };
                                    db.collection("code").add(userInfo).then(
                                          (DocumentReference doc) => print(
                                              'DocumentSnapshot added with ID: ${doc.id}'),
                                        );
                                    try {
                                      CollectionReference tripUdate =
                                          FirebaseFirestore.instance
                                              .collection("trips");

                                      Map<String, dynamic> codeFeild = {
                                        "generated_code":
                                            generated_code.toString()
                                      };
                                      tripUdate.doc(tripDoc).update(codeFeild);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Code Generated")));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Done",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Try again!")));
                    }
                    // __________________________add trip-id to users collection _____________________________________________________

                    CollectionReference db3 =
                        await FirebaseFirestore.instance.collection("users");
                    Map<String, dynamic> mytripdoc = {
                      "trip_id": tripDoc,
                      "creator": "1",
                    };

                    db3.doc(userDocName).update(mytripdoc);

                    // _____________________________________partcipant _________________________________________________________________

                    Map participantName = {"name": name};
                    Map participantEmail = {"email": email};

                    CollectionReference parti =
                        FirebaseFirestore.instance.collection("participants");

                    Map<String, dynamic> PartiField = {
                      "trip_id": tripDoc,
                      "Name": participantName,
                      "Email": participantEmail,
                    };
                    parti.add(PartiField);

                    // _________________________________________________________________________________________________________________

                    // __________________________add trip-id to tools per trip collection _____________________________________________________

                    CollectionReference db4 = await FirebaseFirestore.instance
                        .collection("tools per trip");
                    Map<String, dynamic> mytripdoc2 = {"trip_id": tripDoc};
                    db4.doc(docFortools).update(mytripdoc2);
                    // __________________________________________________________________________________________________________________
                    // __________________________add trip-id to loc collection  _____________________________________________________

                    CollectionReference db5 =
                        await FirebaseFirestore.instance.collection("loc");
                    Map<String, dynamic> mytripdoc3 = {"trip_id": tripDoc};
                    db5.doc(docForloc).update(mytripdoc3);
                  },
                  child: Text("Generate Code"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary_color,
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

  String getBase64RandomString(int length) {
    var random = Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
