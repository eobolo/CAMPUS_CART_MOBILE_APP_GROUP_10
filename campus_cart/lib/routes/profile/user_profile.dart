import 'dart:io';
import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:campus_cart/controllers/meal_image_controller.dart';
import 'package:campus_cart/controllers/profile_image_controller.dart';
import 'package:campus_cart/controllers/search_controller.dart';
import 'package:campus_cart/controllers/setup_delivery_controller.dart';
import 'package:campus_cart/controllers/setup_operation_controller.dart';
import 'package:campus_cart/controllers/store_logo_controller.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserStateController userStateController =
      Get.find<UserStateController>();
  final ProfileImageController profileImageController =
      Get.find<ProfileImageController>();

  XFile? _profileImage;

  Future<void> _pickStoreLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedLogo =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedLogo;
    });
    try {
      await profileImageController.uploadImage(
          _profileImage, userStateController.loggedInuser.uid);
    } catch (e) {
      //
    }
  }

  void _goToStoreProfile() {
    Navigator.pushNamed(context, '/store_profile');
  }

  void _goToSplashStore() {
    Navigator.pushNamed(context, '/splash_store');
  }

  void _goToSetupStore() {
    Navigator.pushNamed(context, '/setup_store');
  }

  void _goToEditProfile() {
    Navigator.pushNamed(context, '/edit_profile');
  }

  void _goToSecurity() {
    Navigator.pushNamed(context, '/security');
  }

  void resetAllControllers() {
    // CartController
    Get.find<CartController>().reset();

    // MealImageController
    Get.find<MealImageController>().reset();

    // AllSearchController
    Get.find<AllSearchController>().reset();

    // SetupDeliveryController
    Get.find<SetupDeliveryController>().reset();

    // SetupOperationController
    Get.find<SetupOperationController>().reset();

    // StoreLogoStateController
    Get.find<StoreLogoStateController>().reset();

    // UserStateController
    Get.find<UserStateController>().reset();
  }

  void _signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      resetAllControllers();
      if (mounted) {
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(child: Text("logging out failed. $e")),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5C147),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Column(
            children: [
              SizedBox(
                width: 400.0,
                height: 320.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 400.0,
                        height: 70.0,
                        child: Stack(
                          children: [
                            // Back Button aligned to the left
                            // Back button at the top-left
                            Positioned(
                              top: 15.0,
                              left: 0,
                              width: 40,
                              height: 40,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon:
                                      const Icon(Icons.arrow_back_ios_rounded),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipOval(
                                child:
                                    userStateController.loggedInuser.photoURL ==
                                            null
                                        ? _profileImage == null
                                            ? Image.asset(
                                                'assets/images/profile.png',
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                              )
                                            : Image.file(
                                                File(_profileImage!.path),
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                              )
                                        : Image.network(
                                            userStateController
                                                .loggedInuser.photoURL,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                              ),
                              Positioned(
                                top: 60,
                                left: 60,
                                child: GestureDetector(
                                  onTap: _pickStoreLogo,
                                  child: Image.asset(
                                    "assets/images/profile_picker.png",
                                    width: 26.0,
                                    height: 26.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          userStateController.loggedInuser.displayName ??
                              "Anonymous",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 13),
                      ],
                    ),
                    Container(
                      width: 285.0,
                      height: 55.0,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userStateController.campusCartUser["isVendor"] != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFDEACB),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Vendor store created',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 16, 16, 16),
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    TextButton(
                                      onPressed: _goToStoreProfile,
                                      child: const Row(
                                        children: [
                                          Text(
                                            'Visit store',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 3.0,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 15,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFDEACB),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Are you a vendor?',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 16, 16, 16),
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    TextButton(
                                      onPressed: _goToSplashStore,
                                      child: const Row(
                                        children: [
                                          Text(
                                            'Set up store',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 3.0,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 15,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 540.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Background container
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    // Menu container
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.016,
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFF0F4F9), // Light background color
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              imagePath: "assets/images/shop.png",
                              title: 'Edit Store',
                              onTap: _goToSetupStore,
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              thickness: 0.1,
                            ),
                            _buildMenuItem(
                              imagePath: "assets/images/user_edit.png",
                              title: 'Edit Profile',
                              onTap: _goToEditProfile,
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              thickness: 0.1,
                            ),
                            _buildMenuItem(
                              imagePath: "assets/images/lock.png",
                              title: 'Security',
                              onTap: _goToSecurity,
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              thickness: 0.1,
                            ),
                            _buildMenuItem(
                              imagePath: "assets/images/location.png",
                              title: 'Addresses',
                              onTap: () {},
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              thickness: 0.1,
                            ),
                            _buildMenuItem(
                              imagePath: "assets/images/call.png",
                              title: 'Contact',
                              onTap: () {},
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              thickness: 0.1,
                            ),
                            _buildMenuItem(
                              imagePath: "assets/images/message_question.png",
                              title: 'FAQs',
                              onTap: () {},
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              thickness: 0.1,
                            ),
                            _buildMenuItem(
                              imagePath: "assets/images/export.png",
                              title: 'Logout',
                              onTap: _signOutUser,
                              textColor: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          imagePath,
          width: 20.0,
          height: 20.0,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black54,
      ),
      onTap: onTap,
    );
  }
}
