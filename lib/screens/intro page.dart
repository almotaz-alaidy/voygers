import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro screens/screen_one.dart';
import 'intro screens/screen_two.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 1);
            });
          },
          children: [
            FirstScreen(),
            SeconedScreen(),
          ],
        ),
        Container(
            alignment: Alignment(0.0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(controller: _controller, count: 2),
                SizedBox(
                  width: 15,
                ),
                onLastPage
                    ? Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "login_screen");
                            },
                            child: Text("signIn")),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: ElevatedButton(
                            onPressed: () {
                              _controller.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: Text("Next")),
                      )
              ],
            )),
      ],
    ));
  }
}
