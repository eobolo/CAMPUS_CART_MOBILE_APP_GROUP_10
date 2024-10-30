import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/stores/init_store.dart';
import 'package:campus_cart/routes/stores/storeprofile.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:get/get.dart';

class VendorSetupScreen extends StatelessWidget {
  VendorSetupScreen({super.key});
  final UserStateController userStateController =
      Get.find<UserStateController>();

  // navigating to pages
  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        // Navigator.pushNamed(context, '/orders');
        break;
      case 3:
        Navigator.pushNamed(context, '/splash_store');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _navigateToPage(index, context);
          },
          currentIndex: 3,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff202020),
          ),
          selectedItemColor: const Color(0xff202020),
          unselectedItemColor: const Color(0xff606060),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff606060),
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.home, color: Color(0xff606060)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.searchNormal),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.bag_2),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.shop),
              label: 'Your Store',
            ),
          ],
        ),
        body: userStateController.campusCartUser["isVendor"] != null
            ? StoreProfile()
            : InitStore());
  }
}
