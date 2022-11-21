import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:voygares/compononet/colors.dart';
import 'package:voygares/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: primary_color,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(100))),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "WELCOME ",
                        style: GoogleFonts.aclonica(
                            textStyle: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "TO",
                        style: GoogleFonts.aclonica(
                            textStyle: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        )),
                      ),
                      Text(
                        "VOYAGERS",
                        style: GoogleFonts.aclonica(
                            textStyle: TextStyle(
                          fontSize: 65,
                          color: Colors.black,
                        )),
                      ),

                      // Text(
                      //   "PLEASURE",
                      //   style: TextStyle(
                      //       fontSize: 35,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                  //  Image(
                  //   image: AssetImage("images/travel_main.gif"),
                  // ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: primary_color,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Spacer(),
                          Lottie.asset("images/panda.json",
                              width: 100, height: 100),
                          // Text(
                          //   "Voygers",
                          //   style: TextStyle(
                          //     fontSize: 28,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Spacer(),
                          Text(
                            "Great choice to Organize your trips",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aclonica(
                                textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black38,
                              wordSpacing: 2.5,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            )),
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                height: 60,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                color: primary_color,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()));
                                },
                                child: Text(
                                  "Get Started",
                                  style: GoogleFonts.aclonica(
                                      textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
