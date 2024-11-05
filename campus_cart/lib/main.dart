import 'package:campus_cart/routes/auth/forgot_password/forgot_password_page.dart';
import 'package:campus_cart/routes/auth/login.dart';
import 'package:campus_cart/routes/auth/terms_and_conditions.dart';
import 'package:campus_cart/routes/home/getstartedpage.dart';
import 'package:campus_cart/routes/home/home.dart';
import 'package:campus_cart/routes/home/search_screen.dart';
import 'package:campus_cart/routes/meal_deals/all_kitchen.dart';
import 'package:campus_cart/routes/meal_deals/meal_deals.dart';
import 'package:campus_cart/routes/orders/orders.dart';
import 'package:campus_cart/routes/profile/user_profile.dart';
import 'package:campus_cart/routes/store/create_menu.dart';
import 'package:campus_cart/routes/store/edit_menu.dart';
import 'package:campus_cart/routes/store/setup_operations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:campus_cart/controllers/user_controllers.dart';
import 'firebase_options.dart';
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
  // WidgetsFlutterBinding.ensureInitialized();

  // // register firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*
    register your controllers
    - UserStateContoller
  */
  // Get.put(UserStateController());
  Get.put(
      // UserStateController());
      Get.lazyPut(() => UserStateController()));

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); //  Add key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Orders from Favourite Uni 😁",
      debugShowCheckedModeBanner: false,
      home: const MainWidget(), // Start with MainWidget
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
        '/setup_delivery': (context) => const DeliverySetupScreen(),
        '/store_profile': (context) => StoreProfile(),
        '/splash_store': (context) => const SplashStore(),
        '/user_profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen(
              query: '',
            ),
        '/meal_deals': (context) => const MealDeals(),
        '/all_kitchens': (context) => const AllKitchens(),
        '/create_menu': (context) => const CreateMenuScreen(),
        '/edit_menu': (context) => const EditMenuScreen(),
        // ignore: equal_keys_in_map
        '/setup_delivery': (context) => const DeliverySetupScreen(),
        '/setup_operation': (context) => const SetupOperationsScreen(),
        '/orders': (context) => const Cart(),
      },
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key}); //  Add key parameter

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<Widget> loadPages = [const SplashScreen(), const Getstartedpage()];
  int page = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        page = 1; // Switch to the next page after the delay
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadPages[page]; // Display the current page based on the index
  }
}
