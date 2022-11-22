import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';
import 'package:voygares/compononet/colors.dart';
import 'package:voygares/utils/binding/HomeBinding.dart';

import '../compononet/catagory/catagoryList.dart';
import 'TripCreate.dart';
import 'bottom_appbar.dart';
import 'login_screen.dart';

String? logic;

String? userDocName;

final firebaseUser = FirebaseAuth.instance.currentUser;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

void getpa() {
  GetPage(
    name: '/',
    page: () {
      return Container();
    },
    binding: HomeBinding(),
  );
}

class _MainPageState extends State<MainPage> {
  String? uidUser;

  CollectionReference trip = FirebaseFirestore.instance.collection("trips");

  CollectionReference userDb = FirebaseFirestore.instance.collection("users");
  FirebaseAuth myUser = FirebaseAuth.instance;
  GetCurrentTripid() {
    FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: currentUser.currentUser!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              userTripId = element["trip_id"].toString();
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
              print("value of current user trip-id variable: $userTripId");
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: currentUser.currentUser!.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element["trip_id"].toString());
              logic = element["trip_id"].toString();
            }));
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    print("value of logic variable: $logic");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        title: Text(
          "Lets Go! Voyager",
          style: GoogleFonts.aclonica(
              textStyle: TextStyle(
            color: Colors.white,
          )),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                )),
            icon: Lottie.asset("images/panda.json", width: 80, height: 80),
          )
        ],
      ),
      backgroundColor: primary_color,
      body: Stack(
        children: [
          Image(
            image: AssetImage(
              "images/food.png",
            ),
            color: primary_color,
          ),
          Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          StreamBuilder(
                            stream: trip.snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.hasData) {
                                List trip_info = snapshot.data!.docs;
                                // if (trip_info[3]['privacy'] == true)
                                return CarouselSlider.builder(
                                  itemCount: trip_info.length,
                                  itemBuilder: (BuildContext context, i,
                                      int pageViewIndex) {
                                    if (trip_info[i]['privacy'] == "true") {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: GradientBoxBorder(
                                            gradient: LinearGradient(
                                              colors: [
                                                primary_color,
                                                primary_color.withOpacity(0.1),
                                              ],
                                            ),
                                            width: 4.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50)),
                                        ),
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      width: 300,
                                                      height: 300,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Image(
                                                          image: NetworkImage(
                                                            "${trip_info[i]['adsImage']}",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 20,
                                                      right: 10,
                                                      left: 10,
                                                      bottom: 10,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: primary_color
                                                                .withOpacity(
                                                                    0.45),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: FittedBox(
                                                          child: Text(
                                                            trip_info[i]
                                                                ['tripName'],
                                                            style: GoogleFonts
                                                                .aclonica(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 80.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  trip_info[i]['disc'],
                                                  style: GoogleFonts.aclonica(
                                                    textStyle: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primary_color,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "Capacity: ${trip_info[i]['cap']}",
                                                  style: GoogleFonts.aclonica(
                                                    textStyle: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primary_color,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50),
                                                  child: Text(
                                                    "Date: ${trip_info[i]['date']}",
                                                    style: GoogleFonts.aclonica(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: primary_color,
                                                      ),
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  " ${trip_info[i]['cost']} JOD",
                                                  style: GoogleFonts.aclonica(
                                                    textStyle: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primary_color,
                                                    ),
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (trip_info[i]['privacy'] ==
                                        "false") {
                                      return Container(
                                        child:
                                            Lottie.asset("images/panda.json"),
                                      );
                                    } else
                                      return Container(
                                        child:
                                            Lottie.asset("images/panda.json"),
                                      );
                                  },
                                  options: CarouselOptions(
                                    height: 300,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                );
                              }
                              return const Center(
                                child: Text('Check your connection'),
                              );
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: AlertDialog(
                    backgroundColor: primary_color,
                    title: Lottie.asset("images/panda.json",
                        width: 100, height: 100),
                    content: Container(
                      width: 100,
                      height: 150,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              icon: Image.asset(
                                "images/bus3.png",
                                color: Colors.white,
                                width: 30,
                                height: 30,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: primary_color),
                              onPressed: () async {
                                // _________________________________________logic test to make sure thate the  user cretae just one trip _________
                                print(
                                    "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

                                FirebaseFirestore.instance
                                    .collection("users")
                                    .where("uid",
                                        isEqualTo: currentUser.currentUser!.uid)
                                    .get()
                                    .then((value) =>
                                        value.docs.forEach((element) {
                                          print(element["trip_id"].toString());
                                          logic = element["trip_id"].toString();
                                        }));
                                print(
                                    "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

                                print("value of logic variable: $logic");
                                // ____________________________________________________________________________________________________________________

                                if (logic == "null") {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return CreateTrip();
                                    },
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "you have already created trip")));
                                }
                              },
                              label: Text(
                                "Create a Trip",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: primary_color),
                                icon: Image.asset(
                                  "images/united.png",
                                  color: Colors.white,
                                  width: 30,
                                  height: 30,
                                ),
                                onPressed: () async {
                                  print(
                                      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .where("uid",
                                          isEqualTo:
                                              currentUser.currentUser!.uid)
                                      .get()
                                      .then((value) =>
                                          value.docs.forEach((element) {
                                            print(
                                                element["trip_id"].toString());
                                            logic =
                                                element["trip_id"].toString();
                                          }));
                                  print(
                                      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

                                  print("value of logic variable: $logic");
                                  GetCurrentTripid();
                                  // ____________________________________________________________________________________________________________________

                                  if (logic == "null") {
                                    Navigator.pushNamed(context, "join_trip");
                                  } else {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return TripPage();
                                      },
                                    ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "you have already joined trip")));
                                  }
                                },
                                label: Text(
                                  "Join a Trip",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              });
        },
        backgroundColor: primary_color,
        child: Lottie.asset("images/panda.json", width: 100, height: 100),
      ),
    );
  }
}
