import 'package:flutter/material.dart';
import 'package:voygares/compononet/colors.dart';

// ignore: must_be_immutable
class RegularTextFeild extends StatelessWidget {
  RegularTextFeild(
      {required this.hintText,
      required this.myAssetImage,
      required this.myController,
      required this.myLabel,
      required this.myMaxLine});

  String? hintText;

  String? myAssetImage;

  String? myLabel;

  TextEditingController myController = new TextEditingController();

  int? myMaxLine;
  TextInputType? mytextinput;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "$hintText",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary_color),
          ),
          suffixIcon: Image(
            image: AssetImage("$myAssetImage"),
            color: primary_color,
            width: 30,
            height: 30,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primary_color),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary_color),
          ),
          label: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "$myLabel",
                style: TextStyle(color: Colors.black),
              ))),
      controller: myController,
      maxLines: myMaxLine,
    );
  }
}
