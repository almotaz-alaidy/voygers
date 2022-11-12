import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class Ads extends StatefulWidget {
  const Ads({super.key});

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  int i = 0;
  final CollectionReference trip =
      FirebaseFirestore.instance.collection("trips");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: trip.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  itemBuilder: (BuildContext context, i, int pageViewIndex) {
                    if (trip_info[i]['privacy'] == "true") {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://img.freepik.com/free-vector/black-wallpaper-with-motion-lines-background_1017-30151.jpg"),
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: Text("this trip is private"),
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
        ],
      ),
    );
  }
}
