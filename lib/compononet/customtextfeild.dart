import 'package:flutter/material.dart';
import 'package:voygares/compononet/colors.dart';

class customTextfeild extends StatelessWidget {
  customTextfeild({required this.controller, required this.text});
  TextEditingController controller = TextEditingController();
  String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (data) {
          if (data == null || data.trim().isEmpty) {
            return "Required field";
          }
        },
        cursorColor: primary_color,
        enabled: true,
        controller: controller,
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
              "$text",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
