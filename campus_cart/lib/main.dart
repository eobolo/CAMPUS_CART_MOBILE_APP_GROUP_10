import 'package:campus_cart/routes/home/getstartedpage.dart';
import 'package:campus_cart/routes/home/splashpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:campus_cart/routes/auth/sign_up.dart';
import 'package:campus_cart/routes/controllers/user_controllers.dart';

void main() async {
  // Ensure that Flutter's bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // register firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*
    register your controllers
    - UserStateContoller
  */
  Get.put(UserStateController());

  // run The App
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> loadPages = [const SplashScreen(), const Getstartedpage()];
  int page = 0;

  /*
    Async delay for the SplashScreen,
    before switching to homePage.
  */
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        page = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Orders from Favourite Uni 😁",
      home: loadPages[page],
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
