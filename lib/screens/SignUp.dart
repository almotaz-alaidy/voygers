import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voygares/compononet/customtextfeild.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  String? phonenumber;
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
                    "JOIN VOYAGER FAMILY",
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
                          ElevatedButton.icon(
                            icon: Image.asset(
                              "images/calendar.gif",
                              width: 25,
                              height: 25,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
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
                            label: Text("date of birthe"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  2,
                                ),
                                color: Colors.green),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (value) {
                                phonenumber = value.toString();
                              },
                              inputDecoration: InputDecoration(
                                hintText: "Phone Number",
                                contentPadding: EdgeInsets.all(6),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20, bottom: 20),
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  focusColor: Colors.green,
                                  fillColor: Colors.green,
                                  hoverColor: Colors.green,
                                  helperText: "Select Your Gender",
                                ),
                                autovalidateMode: AutovalidateMode.disabled,
                                disabledHint: Text("data"),
                                iconEnabledColor: Colors.green,
                                focusColor: Colors.green,
                                autofocus: true,
                                dropdownColor: Colors.green,
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
                                  icon: Image.asset(
                                    "images/sign-up.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
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
                                          "phone": phonenumber.toString(),
                                          "Email": _email.text,
                                          "Password": _pass.text,
                                          "uid": authobj.currentUser!.uid,
                                          "age": datetime.toString(),
                                          "gender": Gender
                                        };
                                        db.collection("users").add(userInfo).then(
                                            (DocumentReference doc) => print(
                                                'DocumentSnapshot added with ID: ${doc.id}'));
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
