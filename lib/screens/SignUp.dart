import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SigupScreen extends StatefulWidget {
  const SigupScreen({super.key});

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {
  bool showPassword = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 500,
              color: Color.fromARGB(255, 42, 209, 16),
              child: Lottie.asset(
                "images/earkickwelcomeanimation.json",
              ),
            ),
            Container(
              decoration: BoxDecoration(),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                  ),
                  // Text(
                  //   "Voyager",
                  //   style: TextStyle(
                  //       fontSize: 30, color: Color.fromARGB(255, 17, 13, 13)),
                  // ),
                  SizedBox(
                    height: 280,
                  ),
                  // Text(
                  //   "Registration page",
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            label: Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                "Email or mobile number",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _pass,
                          obscureText: showPassword,
                          decoration: InputDecoration(
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
                                  )),
                              enabledBorder: InputBorder.none,
                              label: Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Password",
                                    style: TextStyle(color: Colors.black),
                                  ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 42, 209, 16),
                                )),
                                onPressed: () async {
                                  try {
                                    UserCredential muUser = await auth
                                        .createUserWithEmailAndPassword(
                                            email: _email.text,
                                            password: _pass.text);
                                    Navigator.pushNamed(context, "membership");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("added sucessfuly")));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("something went wrong")));
                                  }
                                },
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(color: Colors.black),
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
                                      color: Color.fromARGB(255, 42, 209, 16),
                                      fontSize: 20),
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
