import 'package:flutter/material.dart';

import '../compononet/colors.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary_color,
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28),
        SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ],
    );
  }
}
