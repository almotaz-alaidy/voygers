import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:voygares/compononet/colors.dart';
import 'package:voygares/compononet/customtextfeild.dart';
import 'package:voygares/screens/login_screen.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> myGlobalKey = GlobalKey();

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Password reset link sent Check your email"),
          );
        },
      );
    } on FirebaseException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rest Password",
          style: GoogleFonts.aclonica(
              textStyle: TextStyle(
            color: Colors.white,
          )),
        ),
        backgroundColor: primary_color,
      ),
      body: Form(
        key: myGlobalKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Lottie.asset("images/panda.json"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Enter Your Email To Reset Password",
                  style: GoogleFonts.aclonica(
                      textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              customTextfeild(
                  controller: emailController, text: "Enter Your Email"),
              SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                icon: Image.asset(
                  "images/rotate.png",
                  width: 25,
                  height: 25,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(backgroundColor: primary_color),
                onPressed: () {
                  if (myGlobalKey.currentState!.validate()) {
                    try {
                      passwordReset();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Your password is reset")));
                      // Navigator.pushReplacement(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return SignIn();
                      //   },
                      // ));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Somthing wrong ")));
                    }
                  }
                },
                label: Text(
                  "Reset Password",
                  style: GoogleFonts.aclonica(
                      textStyle: TextStyle(
                    color: Colors.white,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//  