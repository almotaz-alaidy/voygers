import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:voygares/compononet/colors.dart';
import 'package:voygares/compononet/customtextfeild.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

String? userdoc;

class SigupScreen extends StatefulWidget {
  const SigupScreen({super.key});

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {
  DateTime datetime = DateTime(1970);
  int age = 1;
  bool showPassword = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  GlobalKey<FormState> mykey = GlobalKey();
  List MyItems = ["Female", "Male"];
  String Gender = "Male";
  String phonenumber = "00";
  TextEditingController _phone = TextEditingController();
  String Code = "+962";
  final countryPicker = const FlCountryCodePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: primary_color,
              height: 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Voyager",
                    style: GoogleFonts.aclonica(
                        textStyle: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    )),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "JOIN VOYAGER FAMILY",
                    style: GoogleFonts.aclonica(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white30,
                            fontWeight: FontWeight.w100)),
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
                      child: Form(
                        key: mykey,
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  borderSide: BorderSide(color: primary_color),
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
                                    color: primary_color,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary_color),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary_color),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                label: Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Password",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          customTextfeild(controller: _name, text: "Name"),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              cursorColor: primary_color,
                              controller: _phone,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary_color),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary_color),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary_color),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                label: Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Phone Number",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                prefix: Container(
                                  height: 30,
                                  child: TextButton(
                                      onPressed: () async {
                                        final code = await countryPicker
                                            .showPicker(context: context);

                                        if (code != null) {
                                          print(code.dialCode);
                                          Code = code.dialCode.toString();
                                          phonenumber = Code + _phone.text;
                                          print(phonenumber);
                                        }
                                        ;
                                      },
                                      child: Text(
                                        Code,
                                        style: TextStyle(color: primary_color),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.calendar_month),

                            // Image.asset(
                            //   "images/calendar.gif",
                            //   width: 25,
                            //   height: 25,
                            // ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primary_color),
                            onPressed: (() async {
                              DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: datetime,
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2003),
                              );
                              if (dateTime == null)
                                return;
                              else {
                                setState(() {
                                  datetime = dateTime;
                                });
                              }
                            }),
                            label: Text(
                              "Date of Birth",
                              style: GoogleFonts.aclonica(
                                  textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Container(
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(
                          //         2,
                          //       ),
                          //       color: primary_color),
                          //   child: InternationalPhoneNumberInput(
                          //     onInputChanged: (value) {
                          //       phonenumber = value.toString();
                          //     },
                          //     inputDecoration: InputDecoration(
                          //       hintText: "Phone Number",
                          //       contentPadding: EdgeInsets.all(6),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20, bottom: 20),
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  focusColor: primary_color,
                                  fillColor: primary_color,
                                  hoverColor: primary_color,
                                  isCollapsed: true,
                                  helperText: "Select Your Gender",
                                ),
                                autovalidateMode: AutovalidateMode.disabled,
                                disabledHint: Text("data"),
                                iconEnabledColor: primary_color,
                                focusColor: primary_color,
                                autofocus: true,
                                dropdownColor: primary_color,
                                iconDisabledColor: primary_color,
                                icon: Icon(Icons.sort),
                                hint: Text("Please Select from This"),
                                value: Gender,
                                items: MyItems.map((e) => DropdownMenuItem(
                                      enabled: true,
                                      child: Text(
                                        "$e",
                                        style: TextStyle(),
                                      ),
                                      value: e,
                                    )).toList(),
                                onChanged: ((val) {
                                  setState(() {
                                    Gender = val.toString();
                                  });
                                })),
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
                                  icon: Lottie.asset("images/panda.json",
                                      width: 50, height: 50),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primary_color),
                                  onPressed: () async {
                                    if (mykey.currentState!.validate()) {
                                      try {
                                        FirebaseFirestore db =
                                            FirebaseFirestore.instance;

                                        var authobj = FirebaseAuth.instance;
                                        UserCredential myVoyager = await authobj
                                            .createUserWithEmailAndPassword(
                                                email: _email.text,
                                                password: _pass.text);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "You Became a Voyager!")));
                                        Map<String, dynamic> userInfo = {
                                          "Name": _name.text,
                                          "phone": phonenumber,
                                          "Email": _email.text,
                                          "Password": _pass.text,
                                          "uid": authobj.currentUser!.uid,
                                          "age": datetime.toString(),
                                          "gender": Gender,
                                          "trip_id": null,
                                          "profile image": null
                                        };
                                        db
                                            .collection("users")
                                            .add(userInfo)
                                            .then((DocumentReference doc) {
                                          // _________to make globale variable have the value of user document _______________________________
                                          userdoc = doc.id.toString();

                                          // ____________________________________________________________________________________
                                        });
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("something went wrong"),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  label: Text(
                                    "SignUp",
                                    style: GoogleFonts.aclonica(
                                        textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
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
                                    style: GoogleFonts.aclonica(
                                        textStyle: TextStyle(
                                      fontSize: 20,
                                      color: primary_color,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ]),
                      ),
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
