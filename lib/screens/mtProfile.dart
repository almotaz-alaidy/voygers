import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../model/api.dart';
import 'bottom_appbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameControllertoEdit = TextEditingController();
  TextEditingController emailControllertoEdit = TextEditingController();
  TextEditingController phoneControllertoEdit = TextEditingController();
  FirebaseAuth myUser = FirebaseAuth.instance;
  String? userDocName;
  final currentUser = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: currentUser.currentUser!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element["trip_id"].toString());
              logic1 = element["trip_id"].toString();
            }));
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    print("value of logic variable: $logic1");
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
  }

  updatename() async {
    CollectionReference updatename =
        FirebaseFirestore.instance.collection("users");

    updatename.doc(userDocName).update({"Name": nameControllertoEdit.text});
  }

  updatephone() async {
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
    CollectionReference updatename =
        FirebaseFirestore.instance.collection("users");

    updatename.doc(userDocName).update({"phone": phoneControllertoEdit.text});
  }

  CollectionReference myuser = FirebaseFirestore.instance.collection("users");

  final auth = FirebaseAuth.instance;

  // ____________________________________________________select profile image ________________________________
  File? imageProfile;

  Future SelectProfileImage() async {
    final imagePath = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (imagePath == null) return;
    final myImagePath = imagePath.files.single.path!;

    setState(() {
      imageProfile = File(myImagePath);
    });
  }

  // _____________________________________________________________________________________________________________
  // ____________________________________uploed profile image _____________________________________________________
  UploadTask? task5;
  String? profileUrl;

  Future uploedProfileImage() async {
    if (imageProfile == null) return;

    final fileName = basename(imageProfile!.path);
    final destination = 'profileImage/$fileName';

    task5 = FirebaseApi.uploadFile(destination, imageProfile!);
    setState(() {});

    if (task5 == null) return;

    final sssss = await task5!.whenComplete(() {});
    final urlDownload = await sssss.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    final ref =
        FirebaseStorage.instance.ref().child('profileImage').child('$fileName');
    await ref.putFile(imageProfile!);
    profileUrl = await ref.getDownloadURL();
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

    print('Download-Link: $urlDownload');
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    CollectionReference db3 =
        await FirebaseFirestore.instance.collection("users");
    Map<String, dynamic> userdoc = {
      "profile image": profileUrl,
    };

    db3.doc(userDocName).update(userdoc);
  }
  // _____________________________________________________________________________________________________________

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[index];
                    return Container(
                        height: 600,
                        child: DrawerHeader(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(children: [
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 30),
                                        child: CircleAvatar(
                                          radius: 71,
                                          backgroundColor: Colors.green,
                                          child: CircleAvatar(
                                            radius: 65,
                                            backgroundColor: Colors.green,
                                            backgroundImage: logic1 == null
                                                ? null
                                                : NetworkImage(
                                                    "${x['profile image']}"),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 120,
                                          left: 110,
                                          child: RawMaterialButton(
                                            elevation: 10,
                                            fillColor: Colors.green,
                                            child: Icon(Icons.add_a_photo),
                                            padding: EdgeInsets.all(15.0),
                                            shape: CircleBorder(),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'Choose option',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ListBody(
                                                          children: [
                                                            InkWell(
                                                              onTap:
                                                                  SelectProfileImage,
                                                              splashColor:
                                                                  Colors.green,
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .image,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'choose image ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap:
                                                                  uploedProfileImage,
                                                              splashColor:
                                                                  Colors.green,
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .upload,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'uoloed image',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ))
                                    ],
                                  ),
                                  // _______________________________________________________________________________________________
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     showDialog(
                                  //       context: context,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //           actions: [
                                  //             TextButton.icon(
                                  //               onPressed: () {
                                  //                 print("object");
                                  //               },
                                  //               icon: Icon(Icons.camera),
                                  //               label: Text("camera"),
                                  //             ),
                                  //             TextButton.icon(
                                  //                 onPressed: () {},
                                  //                 icon: Icon(Icons
                                  //                     .browse_gallery_outlined),
                                  //                 label: Text("gallery")),
                                  //             SizedBox(
                                  //               width: 10,
                                  //             ),
                                  //           ],
                                  //           title: Text("Add image"),
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   child: CircleAvatar(
                                  //     radius: 100,
                                  //     backgroundImage:
                                  //         AssetImage("images/3.png"),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  /// list tile name
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text("${x['Name']}"),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        nameControllertoEdit.value =
                                            TextEditingValue(
                                                text: "${x['Name']}");
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Edit Name"),
                                              actions: [
                                                Container(
                                                  child: TextFormField(
                                                    controller:
                                                        nameControllertoEdit,
                                                    decoration: InputDecoration(
                                                        // counterText: x["Name"],
                                                        //  hintText: "${x['Name']}",
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                      child: ElevatedButton(
                                                        onPressed: updatename,
                                                        child: Text("Edit"),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),

                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text("${x['Email']}"),
                                  ),

                                  SizedBox(
                                    height: 6,
                                  ),

                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text("${x['phone']}"),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        phoneControllertoEdit.value =
                                            TextEditingValue(
                                                text: "${x['phone']}");
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Edit phone"),
                                              actions: [
                                                Container(
                                                  child: TextFormField(
                                                    controller:
                                                        phoneControllertoEdit,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      updatephone();
                                                    },
                                                    child: Text("Edit phone"),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),

                                  ListTile(
                                    leading: Icon(Icons.mail),
                                    title: Text("${x['gender']}"),
                                  )
                                ]))));
                  }));
        });
  }
}
