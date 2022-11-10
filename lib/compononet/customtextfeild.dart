import 'package:flutter/material.dart';

class Textfeild extends StatelessWidget {
  Textfeild({required this.controller, required this.text});
  TextEditingController controller = TextEditingController();
  String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        cursorColor: Colors.green,
        enabled: true,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
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
              "$text",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
