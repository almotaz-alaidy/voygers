import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voygares/compononet/customtextfeild.dart';
import 'package:voygares/screens/forgetpas.dart';
import 'package:google_sign_in/google_sign_in.dart';

DocumentReference? doc;
CollectionReference UsersRef = FirebaseFirestore.instance.collection("users");
String? userField;
FirebaseAuth auth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  GlobalKey<FormState> mykey = GlobalKey();
  bool showPassword = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  readFeildFromUsers() {
    UsersRef.where("uid", isEqualTo: auth.currentUser!.uid).get().then((value) {
      value.docs.forEach((element) {
        userField = element["trip_id"];
        print("@@@@@@@@@@@@@@@@@@@@@@@");
        print("the value of current user trip id is :   $userField");
        print("@@@@@@@@@@@@@@@@@@@@@@@");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.green,
                height: 500,
              ),
              Container(
                decoration: BoxDecoration(),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Text(
                      "Voyager",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/bus.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Form(
                        key: mykey,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            SizedBox(
                              height: 30,
                            ),
                            customTextfeild(
                                controller: _email, text: "Enter Your Email"),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (data) {
                                  if (data == null || data.trim().isEmpty) {
                                    return "Required field";
                                  }
                                },
                                controller: _pass,
                                obscureText: showPassword,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        color: Colors.green,
                                        showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                    label: Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(
                                          "Password",
                                          style: TextStyle(color: Colors.black),
                                        ))),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return Forgotpassword();
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 250),
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(color: Colors.green),
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
                              child: ElevatedButton.icon(
                                icon: Image.asset(
                                  "images/data-protection.png",
                                  width: 40,
                                  height: 40,
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  if (mykey.currentState!.validate()) {
                                    try {
                                      // ________________________________________________________________________
                                      readFeildFromUsers();

                                      UserCredential muUser =
                                          await auth.signInWithEmailAndPassword(
                                              email: _email.text,
                                              password: _pass.text);
                                      Navigator.pushNamed(context, "main_page");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("loged in sucessfuly"),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("something went wrong"),
                                        ),
                                      );
                                    }
                                  }
                                },
                                label: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "__________________OR__________________",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              icon: Image.asset(
                                "images/google.png",
                                width: 25,
                                height: 25,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () async {
                                UserCredential myGoogle =
                                    await signInWithGoogle();
                                Navigator.pushNamed(context, "main_page");
                              },
                              label: Text("Login with Google"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
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
                                      "Sign up",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
