import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 127, 236, 115),
                  image: DecorationImage(
                      image: AssetImage("images/10.jpg"), fit: BoxFit.fill)),
              height: 500,
              // child: Lottie.asset(
              //   "images/panda.json",
              // ),
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
                  Text(
                    "Voyager",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  SizedBox(
                    height: 300,
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
                                ),
                                color: Color.fromARGB(191, 173, 122, 11),
                              ),
                              enabledBorder: InputBorder.none,
                              label: Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Password",
                                    style: TextStyle(color: Colors.black),
                                  ))),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 250),
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
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
                                  Color.fromARGB(191, 173, 122, 11),
                                )),
                                onPressed: () async {
                                  try {
                                    UserCredential muUser =
                                        await auth.signInWithEmailAndPassword(
                                            email: _email.text,
                                            password: _pass.text);
                                    Navigator.pushNamed(context, "main_page");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("loged in sucessfuly")));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("something went wrong")));
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.black),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text(
                                " Not have an account? Lets",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "signUp");
                                },
                                child: Text(
                                  "signup",
                                  style: TextStyle(
                                      color: Color.fromARGB(191, 173, 122, 11),
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Give yourself the right to have fun",
                        ),
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
