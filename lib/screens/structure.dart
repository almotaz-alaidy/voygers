import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../compononet/catagory/catagoryList.dart';

class StructureScreen extends StatefulWidget {
  const StructureScreen({super.key});

  @override
  State<StructureScreen> createState() => _StructureScreenState();
}

class _StructureScreenState extends State<StructureScreen> {
  final currentUser = FirebaseAuth.instance;
  String email = "";
  String phoneNum = "";
  String name = "";
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
            onPressed: () => Navigator.pop(context, "MainPage"),
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.green,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("uid", isEqualTo: currentUser.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[index];
                        return Container(
                            child: DrawerHeader(
                          child: Column(children: [
                            Text(x['Email']),
                            Text(x['Name']),
                            Text(x['phone'])
                          ]),
                        ));
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            DrawerHeader(
                child: Column(
              children: [Text(name), Text(email), Text(phoneNum)],
            )),
            Positioned(
              top: 250,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "history");
                },
                icon: Icon(Icons.history, color: Colors.white),
                label: Text(
                  "Old Trips",
                  style: TextStyle(
                      color: Color.fromARGB(255, 245, 206, 252), fontSize: 25),
                ),
              ),
            ),
            Positioned(
              top: 300,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "Trip_Comment");
                },
                icon: Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                label: Text(
                  "Comment On trip",
                  style: TextStyle(
                      color: Color.fromARGB(255, 245, 206, 252), fontSize: 25),
                ),
              ),
            ),
            Positioned(
              top: 350,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.green,
                            title: Text(
                              "Are you Sure you want to end trip?",
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Row(children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ]),
                          );
                        });
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                label: Text(
                  "End trip",
                  style: TextStyle(
                      color: Color.fromARGB(255, 245, 206, 252), fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      // _______________her will appeare the wether __________________________________________________________________________________________
                      Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // children: const [
                          //   Text(
                          //     "voygers",
                          //     style: TextStyle(
                          //       fontSize: 28,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          //   SizedBox(
                          //     height: 10.0,
                          //   ),
                          //   Text(
                          //     "lets organize oure tripe ",
                          //     style: TextStyle(
                          //       color: Colors.black54,
                          //       wordSpacing: 2.5,
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),
                          // ],
                          ),
                      // const Spacer(),
                      Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Image(
                              image: NetworkImage(
                                  "https://static.toiimg.com/photo/msid-86829375/86829375.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // ________________________________________________________________________________________________________________________________
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Services",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CategoryList(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
