import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/visuals/splashvisuals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileEdit extends StatefulWidget {
  const UserProfileEdit({super.key});

  @override
  State<UserProfileEdit> createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  final _formEditProfileKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _onEditProfile() async {
    if (!(_formEditProfileKey.currentState!.validate())) {
      return;
    } else {
      setState(() {
        isLoading = true; // to make circular loading action
      });
      try {
        // update profile and give success message.
        if (emailController.text != "") {
          await userStateController.loggedInuser
              ?.updateEmail(emailController.text.trim());
        }
        if (displayNameController.text != "") {
          await userStateController.loggedInuser
              ?.updateDisplayName(displayNameController.text.trim());
        }
        if (emailController.text != "" || displayNameController.text != "") {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(child: Text("Profile update successfully.")),
              backgroundColor: const Color.fromARGB(255, 49, 255, 52),
            ));
          }
        } else {
          //
        }
        setState(() {
          isLoading =
              false; // remove circular loading action incase user navigates there again
        });
      } catch (e) {
        setState(() {
          isLoading =
              false; // remove circular loading action since error occured
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            backgroundColor: const Color.fromARGB(255, 255, 63, 49),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5C147),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Positioned(
                        top: 55,
                        left: 30,
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_rounded),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/bag-happy-bw.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Campus Cart',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Splashvisuals.textColor,
                              fontFamily: 'Recoleta',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 10.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formEditProfileKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans",
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          validator: (validateEmail) {
                            const String emailPattern =
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            final RegExp emailRegExp = RegExp(emailPattern);
                            if (validateEmail == "") {
                              return null;
                            } else if (!emailRegExp.hasMatch(validateEmail!)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'e.g campuscart@alustudent.com',
                            filled: true,
                            fillColor: const Color(0xFFE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 23.0, horizontal: 30.0),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        const Text(
                          'Profile Name',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: displayNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your display name',
                            filled: true,
                            fillColor: const Color(0xFFE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 23.0, horizontal: 30.0),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        isLoading
                            ? Center(child: const CircularProgressIndicator())
                            : ElevatedButton(
                                // onpressed login validate form and also validate database before redirecting to homepage
                                onPressed: _onEditProfile,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  backgroundColor: Color(0xff202020),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                  minimumSize:
                                      const Size(double.infinity, 60.0),
                                ),
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                    fontFamily: "DM Sans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
