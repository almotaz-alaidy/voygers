import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showPassword = true;

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
                "images/panda.json",
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
                  Text(
                    "Voyager",
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 17, 13, 13)),
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
                                  Color.fromARGB(255, 42, 209, 16),
                                )),
                                onPressed: () {
                                  Navigator.pushNamed(context, "membership");
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
                                      color: Color.fromARGB(255, 42, 209, 16),
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
