import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    // updatename();
    // editemail();
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
              appBar: AppBar(),
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
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            actions: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  print("object");
                                                },
                                                icon: Icon(Icons.camera),
                                                label: Text("camera"),
                                              ),
                                              TextButton.icon(
                                                  onPressed: () {},
                                                  icon: Icon(Icons
                                                      .browse_gallery_outlined),
                                                  label: Text("gallery")),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                            title: Text("Add image"),
                                          );
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 100,
                                      backgroundImage:
                                          AssetImage("images/3.png"),
                                    ),
                                  ),
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

                                  ///list tile email
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text("${x['Email']}"),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        emailControllertoEdit.value =
                                            TextEditingValue(
                                                text: "${x['Email']}");
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Edit Email"),
                                              actions: [
                                                Container(
                                                  child: TextFormField(
                                                    controller:
                                                        emailControllertoEdit,
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
                                                        //////
                                                        onPressed: () {
                                                          // editemail;
                                                          // print(editemail()
                                                          //     .toString());
                                                        },
                                                        child:
                                                            Text("Edit email"),
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

                                  ///list tile phone
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
                                                        onPressed: () {
                                                          updatephone;
                                                        },
                                                        child:
                                                            Text("Edit phone"),
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
                                    leading: Icon(Icons.mail),
                                    title: Text("${x['gender']}"),
                                  )
                                ]))));
                  }));
        });
  }
}
