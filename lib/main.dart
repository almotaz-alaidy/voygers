import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voygares/firebase_options.dart';
import 'package:voygares/screens/TripCreate.dart';
import 'package:voygares/screens/home_screen.dart';
import 'package:voygares/screens/welcom.dart';
import 'package:voygares/utils/binding/HomeBinding.dart';
import 'screens/History.dart';
import 'screens/Main_Page.dart';
import 'screens/SignUp.dart';
import 'screens/TripComment.dart';
import 'screens/bottom_appbar.dart';
import 'screens/join_Trip.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    routes: {
      "main_page": (context) => MainPage(),
      "create_trip": (context) => CreateTrip(),
      "join_trip": (context) => JoinTrip(),
      "trip_page": (context) => TripPage(),
      "history": (context) => History(),
      "Trip_Comment": (context) => Comment_on_trip(),
      "login_screen": (context) => SignIn(),
      "signUp": (context) => SigupScreen(),
    },
    title: "voyger",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: ''),
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
      animationDuration: Duration(seconds: 1),
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
// void main() {
//   runApp(WeatherApp());
// }

// class WeatherApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       getPages: [
//         GetPage(
//           name: '/',
//           page: () => HomeScreen(),
//           binding: HomeBinding(),
//         )
//       ],
//     );
//   }
// }
