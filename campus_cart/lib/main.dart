import 'package:campus_cart/controllers/all_dishes_controller.dart';
import 'package:campus_cart/controllers/all_users_controller.dart';
import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:campus_cart/controllers/meal_image_controller.dart';
import 'package:campus_cart/controllers/profile_image_controller.dart';
import 'package:campus_cart/controllers/search_controller.dart';
import 'package:campus_cart/controllers/setup_delivery_controller.dart';
import 'package:campus_cart/controllers/setup_operation_controller.dart';
import 'package:campus_cart/controllers/store_logo_controller.dart';
import 'package:campus_cart/routes/auth/forgot_password/forgot_password_page.dart';
import 'package:campus_cart/routes/auth/login.dart';
import 'package:campus_cart/routes/auth/terms_and_conditions.dart';
import 'package:campus_cart/routes/home/getstartedpage.dart';
import 'package:campus_cart/routes/home/home.dart';
import 'package:campus_cart/routes/home/search_screen.dart';
import 'package:campus_cart/routes/home/splashpage.dart';
import 'package:campus_cart/routes/kitchen/all_kitchen.dart';
import 'package:campus_cart/routes/meal_deal/meal_deals.dart';
import 'package:campus_cart/routes/profile/security.dart';
import 'package:campus_cart/routes/profile/user_edit.dart';
import 'package:campus_cart/routes/profile/user_profile.dart';
import 'package:campus_cart/routes/stores/create_menu.dart';
import 'package:campus_cart/routes/stores/edit_menu_details.dart';
import 'package:campus_cart/routes/stores/setup_delivery_pop.dart';
import 'package:campus_cart/routes/stores/setup_operations.dart';
import 'package:campus_cart/routes/stores/setup_store.dart';
import 'package:campus_cart/routes/stores/splash_store.dart';
import 'package:campus_cart/routes/stores/storeprofile.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'firebase_options.dart';
import 'package:campus_cart/routes/auth/signup.dart';
import 'package:campus_cart/routes/auth/signup_otp.dart';
import 'package:campus_cart/routes/auth/forgot_password/reset_password_otp.dart';
import 'package:campus_cart/routes/auth/forgot_password/reset_password.dart';

void main() async {
  // Ensure that Flutter's bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // register firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  /*
    register your controllers
    - UserStateContoller
    - StoreLogoStateController
    - SetupDeliveryController
    - SetupOperationController
    - MealImageController
    - AllDishesController
    - AllUsersController
    - CartController
    - AllSearchController
    - ProfileImageController
  */
  Get.put(UserStateController());
  Get.put(StoreLogoStateController());
  Get.put(SetupDeliveryController());
  Get.put(SetupOperationController());
  Get.put(MealImageController());
  Get.put(AllDishesController());
  Get.put(AllUsersController());
  Get.put(CartController());
  Get.put(AllSearchController());
  Get.put(ProfileImageController());
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
        '/splash_store': (context) => VendorSetupScreen(),
        '/setup_store': (context) => const SetUpStore(),
        '/store_profile': (context) => StoreProfile(),
        '/setup_delivery': (context) => DeliverySetupScreen(),
        '/setup_operation': (context) => SetupOperationsScreen(),
        '/create_menu': (context) => CreateMenuScreen(),
        '/edit_menu': (context) => EditMenuDetailsScreen(),
        '/search': (context) => const SearchScreen(
              query: '',
            ),
        '/meal_deals': (context) => const MealDeals(),
        '/all_kitchens': (context) => AllKitchens(),
        '/user_profile': (context) => ProfileScreen(),
        '/edit_profile': (context) => UserProfileEdit(),
        '/security': (context) => Security(),
      },
    );
  }
}
