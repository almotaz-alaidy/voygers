import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

late Uri _url;

class Contact_widget extends StatelessWidget {
  Contact_widget({this.title, this.subTitle, this.icon, this.url, this.col});
  String? title;
  String? subTitle;
  Icon? icon;
  String? url;
  Color? col;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _url = Uri.parse('$url');
        Open();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: col,
        ),
        child: ListTile(
          title: Text(
            "$title",
            style: GoogleFonts.aclonica(
                textStyle: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
          ),
          subtitle: Text(
            "$subTitle",
            style: GoogleFonts.aclonica(
                textStyle: TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
          ),
          leading: icon,
        ),
      ),
    );
  }
}

Future<void> Open() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
