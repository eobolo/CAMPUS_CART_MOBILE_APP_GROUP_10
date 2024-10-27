import 'package:campus_cart/routes/auth/forgot_password/forgot_password_page.dart';
import 'package:campus_cart/routes/auth/login.dart';
import 'package:campus_cart/routes/auth/terms_and_conditions.dart';
import 'package:campus_cart/routes/home/getstartedpage.dart';
import 'package:campus_cart/routes/home/home.dart';
import 'package:campus_cart/routes/home/splashpage.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'package:campus_cart/controllers/user_controllers.dart';
// import 'firebase_options.dart';
import 'package:campus_cart/routes/auth/signup.dart';
import 'package:campus_cart/routes/auth/signup_otp.dart';
import 'package:campus_cart/routes/auth/forgot_password/reset_password_otp.dart';
import 'package:campus_cart/routes/auth/forgot_password/reset_password.dart';
import 'package:campus_cart/routes/store/create_store.dart';
import 'package:campus_cart/routes/store/initial_store_profile.dart';
import 'package:campus_cart/routes/store/second_store_profile.dart';
import 'package:campus_cart/routes/store/setup_delivery.dart';
import 'package:campus_cart/routes/store/splash_store.dart';
import 'package:campus_cart/routes/store/store_profile.dart';
import 'package:campus_cart/controllers/user_controllers.dart';
import 'package:get/get.dart';

void main() async {
  // Ensure that Flutter's bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // // register firebase app
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  /*
    register your controllers
    - UserStateContoller
  */
  // Get.put(UserStateController());
  Get.put(
      UserStateController()); // or Get.lazyPut(() => UserStateController());

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
      debugShowCheckedModeBanner: false,
      home: loadPages[page],
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/signup_otp': (context) => const SignUpOtpVerification(),
        '/terms_and_conditions': (context) => const TermsAndConditions(),
        '/login': (context) => const SignIn(),
        '/forget_password': (context) => const ForgotPasswordPage(),
        '/reset_password_otp': (context) => const OtpResetPassword(),
        '/reset_password': (context) => const ResetPassword(),
        '/home': (context) => const Home(),
        '/setup': (context) => const CreateStore(),
        '/initial_store_profile': (context) => const InitialStoreProfile(),
        '/second_store_profile': (context) => SecondStoreProfile(),
        '/setup_delivery': (context) => const SetupDelivery(),
        '/store_profile': (context) => StoreProfile(),
        '/splash_store': (context) => const SplashStore(),
      },
    );
  }
}
