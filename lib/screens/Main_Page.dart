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
          backgroundColor: Color.fromARGB(255, 29, 101, 118),
          title: Text(
            "Lets Go! Voyager",
            style: TextStyle(
              // fontWeight: FontWeight.bold,
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/8.jpg"), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "create_trip");
                  },
                  icon: Icon(Icons.create, color: Colors.white),
                  label: Text(
                    "Create a trip",
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  )),
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "join_trip");
                  },
                  icon: Icon(Icons.join_full, color: Colors.white),
                  label: Text(
                    "Join a trip",
                    style: TextStyle(fontSize: 50),
                  ))
            ],
          ),
        ));
  }
}
