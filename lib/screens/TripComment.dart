import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voygares/compononet/colors.dart';
import 'package:voygares/screens/login_screen.dart';

class Comment_on_trip extends StatefulWidget {
  const Comment_on_trip({super.key});

  @override
  State<Comment_on_trip> createState() => _Comment_on_tripState();
}

class _Comment_on_tripState extends State<Comment_on_trip> {
  TextEditingController comment = TextEditingController();
  TextEditingController comment_sub = TextEditingController();
  readFeildFromUsers() {
    UsersRef.where("uid", isEqualTo: auth.currentUser!.uid).get().then((value) {
      value.docs.forEach((element) {
        userField = element["trip_id"];
        print("@@@@@@@@@@@@@@@@@@@@@@@");
        print(userField);
        print("@@@@@@@@@@@@@@@@@@@@@@@");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readFeildFromUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "share your comment",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: primary_color,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context, "trip_page"),
            icon: Icon(
              Icons.app_registration,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: comment_sub,
              decoration: InputDecoration(
                  hintText: 'Subject',
                  icon: Icon(Icons.trip_origin_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: comment,
              decoration: InputDecoration(
                  hintText: 'Comment',
                  icon: Icon(Icons.comment),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: Colors.white),
              maxLines: 7,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  FirebaseFirestore commDb = FirebaseFirestore.instance;

                  Map<String, dynamic> userInfo = {
                    "subject": comment_sub.text,
                    "comment": comment.text,
                    "trip_id": userField,
                  };
                  commDb.collection("comments").add(userInfo).then(
                      (DocumentReference doc) =>
                          print('DocumentSnapshot added with ID: ${doc.id}'));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("comment added succecfully")));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Try again!")));
                }
              },
              child: Text("Upload Comment"),
              style: ElevatedButton.styleFrom(backgroundColor: primary_color),
            )
          ],
        ),
      ),
    );
  }
}
