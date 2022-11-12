import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

// ignore: must_be_immutable
class Advice extends StatelessWidget {
  Advice({required this.advice});

  String? advice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.green,
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
            ],
          ),
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                child: Text(
                  'Advice',
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
                '$advice',
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
            ],
          ),
        ),
      ),
    );
  }
}
