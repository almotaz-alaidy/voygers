import 'package:flutter/material.dart';

class Comment_on_trip extends StatefulWidget {
  const Comment_on_trip({super.key});

  @override
  State<Comment_on_trip> createState() => _Comment_on_tripState();
}

class _Comment_on_tripState extends State<Comment_on_trip> {
  TextEditingController comment = TextEditingController();
  TextEditingController comment_sub = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "share your comment",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: comment_sub,
              decoration: InputDecoration(
                  hintText: 'Subject',
                  icon: Icon(Icons.trip_origin_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: Colors.white),
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
            ElevatedButton(
              onPressed: () {},
              //  () async {
              //   try {
              //     FirebaseFirestore db = FirebaseFirestore.instance;

              //     Map<String, dynamic> userInfo = {
              //       "subject": comment_sub.text,
              //       "comment": comment.text
              //     };
              //     db.collection("Comment").add(userInfo).then(
              //         (DocumentReference doc) =>
              //             print('DocumentSnapshot added with ID: ${doc.id}'));
              //     ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text("comment added succecfully")));
              //   } catch (e) {
              //     ScaffoldMessenger.of(context)
              //         .showSnackBar(SnackBar(content: Text("Try again!")));
              //   }
              // },
              child: Text("Upload Comment"),
              style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.purple
                  ),
            )
          ],
        ),
      ),
    );
  }
}
