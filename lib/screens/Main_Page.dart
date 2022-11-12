import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CollectionReference trip =
      FirebaseFirestore.instance.collection("trips");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Lets Go! Voyager",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context, "login_screen"),
              icon: Icon(
                Icons.app_registration,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder(
                    stream: trip.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        List trip_info = snapshot.data!.docs;
                        // if (trip_info[3]['privacy'] == true)
                        return CarouselSlider.builder(
                          itemCount: trip_info.length,
                          itemBuilder:
                              (BuildContext context, i, int pageViewIndex) {
                            if (trip_info[i]['privacy'] == "true") {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  // image: const DecorationImage(
                                  //   fit: BoxFit.cover,
                                  //   image: NetworkImage(
                                  //       "https://img.freepik.com/free-vector/black-wallpaper-with-motion-lines-background_1017-30151.jpg"),
                                  // ),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0.1),
                                      ],
                                    ),
                                    width: 4.0,
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          trip_info[i]['tripName'],
                                          style: GoogleFonts.amiri(
                                            textStyle: const TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      Text(
                                        trip_info[i]['disc'],
                                        style: GoogleFonts.amiri(
                                          textStyle: const TextStyle(
                                            fontSize: 20.0,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Capacity: ${trip_info[i]['cap']}",
                                        style: GoogleFonts.amiri(
                                          textStyle: const TextStyle(
                                            fontSize: 25.0,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Date: ${trip_info[i]['date']}",
                                        style: GoogleFonts.amiri(
                                          textStyle: const TextStyle(
                                            fontSize: 15.0,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        " ${trip_info[i]['cost']} JOD",
                                        style: GoogleFonts.amiri(
                                          textStyle: const TextStyle(
                                            fontSize: 15.0,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (trip_info[i]['privacy'] == "false") {
                              return Container(
                                child: Lottie.asset("images/panda.json"),
                              );
                            } else
                              return Container(
                                color: Colors.black,
                                width: 1,
                                child: Text(""),
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
                            autoPlayInterval: const Duration(seconds: 3),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        ElevatedButton.icon(
                          icon: Image.asset(
                            "images/bus3.png",
                            width: 30,
                            height: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.green),
                          onPressed: () {
                            Navigator.pushNamed(context, "create_trip");
                          },
                          label: Text(
                            "Create a Trip",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.green),
                            icon: Image.asset(
                              "images/united.png",
                              width: 30,
                              height: 30,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "join_trip");
                            },
                            label: Text(
                              "Join a Trip",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
