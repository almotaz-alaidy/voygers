import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voygares/firebase_options.dart';
import 'package:voygares/screens/welcom.dart';
import 'screens/GenerateCode.dart';
import 'screens/History.dart';
import 'screens/Main_Page.dart';
import 'screens/SignUp.dart';
import 'screens/TripComment.dart';
import 'screens/bottom_appbar.dart';
import 'screens/intro page.dart';
import 'screens/join_Trip.dart';
import 'screens/login_screen.dart';
import 'screens/tripCreation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    routes: {
      "main_page": (context) => MainPage(),
      "create_trip": (context) => TripCreation(),
      "join_trip": (context) => JoinTrip(),
      "trip_page": (context) => TripPage(),
      "generate_code": (context) => GenerateCode(),
      "history": (context) => History(),
      "Trip_Comment": (context) => Comment_on_trip(),
      "login_screen": (context) => SignIn(),
      "signUp": (context) => SigupScreen(),
    },
    title: "voyger",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: "",
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 100,
      centered: true,
      animationDuration: Duration(seconds: 10),
      duration: 3000,
      splash: Column(
        children: [
          Image(height: 80, image: AssetImage("images/5.png")),
          Text(
            "VOYGARES",
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
      nextScreen: WelcomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
