import 'package:campus_cart/controllers/user_controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserStateController userStateController = Get.find<UserStateController>();

  @override
  void initState() {
    super.initState();

    // Check if the user is logged in
    if (FirebaseAuth.instance.currentUser == null ||
        userStateController.loggedInuser == null) {
      // Navigate to login if not authenticated
      Future.delayed(Duration.zero, () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    } else {
      // Optionally, update the reactive loggedInuser from FirebaseAuth
      userStateController.loggedInuser = FirebaseAuth.instance.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(userStateController.loggedInuser?.email),
      ),
    );
  }
}
