import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:voygares/wedget/urll.dart';

class ShareCode extends StatefulWidget {
  const ShareCode({super.key});

  @override
  State<ShareCode> createState() => _ShareCodeState();
}

class _ShareCodeState extends State<ShareCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Contact_widget(
            title: "Maps",
            subTitle: "Our Location",
            icon: Icon(
              Ionicons.location,
              color: Colors.white,
            ),
            url:
                'https://www.google.jo/maps/@32.6687618,36.002274,12z?hl=en&authuser=0',
            col: Colors.green,
          ),
          SizedBox(
            height: 10,
          ),
          Contact_widget(
              title: "instgram",
              subTitle: "follow us",
              icon: Icon(
                Ionicons.logo_instagram,
                color: Colors.white,
              ),
              url: 'https://www.instagram.com/',
              col: Colors.green),
          SizedBox(
            height: 10,
          ),
          Contact_widget(
            title: "facebook",
            subTitle: "follow us",
            icon: Icon(
              Icons.facebook,
              color: Colors.white,
            ),
            url: 'https://web.facebook.com/home.php',
            col: Colors.green,
          )
        ],
      ),
    );
  }
}
