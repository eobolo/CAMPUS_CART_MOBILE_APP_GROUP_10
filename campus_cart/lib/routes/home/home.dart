import 'package:campus_cart/controllers/user_controller.dart';
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
          // send user to splash store for now, will change to home later
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "${userStateController.campusCartUser["email"]}, ${userStateController.campusCartUser["PhoneNumber"]}, ${userStateController.campusCartUser["isBuyer"]}"),
      ),
    );
  }
}
