import 'package:campus_cart/firebase_options.dart';
import 'package:campus_cart/routes/auth/forgot_password/forgot_password_page.dart';
import 'package:campus_cart/routes/auth/login.dart';
import 'package:campus_cart/routes/auth/terms_and_conditions.dart';
import 'package:campus_cart/routes/home/getstartedpage.dart';
import 'package:campus_cart/routes/home/home.dart';
import 'package:campus_cart/routes/home/search_screen.dart';
import 'package:campus_cart/routes/home/splashpage.dart';
import 'package:campus_cart/routes/meal_deals/meal_deals.dart';
import 'package:campus_cart/routes/profile/user_profile.dart';
import 'package:campus_cart/routes/store/create_menu.dart';
import 'package:campus_cart/routes/store/edit_menu.dart';
import 'package:campus_cart/routes/store/setup_operations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campus_cart/controllers/user_controllers.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase

  Get.put(UserStateController()); // Register your controllers

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Add key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Orders from Favourite Uni 😁",
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_store', // Change to your splash screen route
      routes: {
        '/splash_store': (context) => const SplashStore(),
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
        '/setup_delivery': (context) => const DeliverySetupScreen(),
        '/store_profile': (context) => StoreProfile(),
        '/user_profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen(),
        '/meal_deals': (context) => const MealDeals(),
        '/most_used_kitchens': (context) => const Getstartedpage(),
        '/create_menu': (context) => const CreateMenuScreen(),
        '/edit_menu': (context) => const EditMenuScreen(),
        '/setup_operation': (context) => const SetupOperationsScreen(),
      },
    );
  }
}
