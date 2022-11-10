import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // FirebaseFirestore db = FirebaseFirestore.instance;

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
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(),
              SizedBox(
                height: 300,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    MaterialButton(
                      splashColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.pushNamed(context, "create_trip");
                      },
                      child: Text(
                        "Create a Trip",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.pushNamed(context, "join_trip");
                      },
                      child: Text(
                        "Join a Trip",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
