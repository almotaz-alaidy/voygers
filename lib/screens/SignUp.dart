import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voygares/compononet/customtextfeild.dart';

class SigupScreen extends StatefulWidget {
  const SigupScreen({super.key});

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {
  bool showPassword = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _mobile = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              height: 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Voyager",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Registration page",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Textfeild(controller: _email, text: "Enter Your Email"),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _pass,
                            obscureText: showPassword,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                label: Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      "Password",
                                      style: TextStyle(color: Colors.black),
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Textfeild(controller: _name, text: "Name"),
                        SizedBox(
                          height: 20,
                        ),
                        Textfeild(
                            controller: _mobile,
                            text: "Enter Your Mobile Number"),
                        Container(
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  try {
                                    FirebaseFirestore db =
                                        FirebaseFirestore.instance;

                                    var authobj = FirebaseAuth.instance;
                                    UserCredential myVoyager = await authobj
                                        .createUserWithEmailAndPassword(
                                            email: _email.text,
                                            password: _pass.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("You Became a Voyager!")));
                                    Map<String, dynamic> userInfo = {
                                      "Name": _name.text,
                                      "phone": _mobile.text,
                                      "Email": _email.text,
                                      "Password": _pass.text,
                                      "uid": authobj.currentUser!.uid,
                                      // "picture": image,
                                    };
                                    db.collection("users").add(userInfo).then(
                                        (DocumentReference doc) => print(
                                            'DocumentSnapshot added with ID: ${doc.id}'));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("something went wrong")));
                                  }
                                },
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(color: Colors.white),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text(
                                "have an account? Lets",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, "login_screen");
                                },
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ]),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
