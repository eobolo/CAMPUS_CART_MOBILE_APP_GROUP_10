import 'package:campus_cart/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class for the forgot password page
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

// state class for the forgot password page
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  bool _isLoading = false;

  // function to send password reset email
  void _sendPasswordResetEmail() async {
    if (!(_formKey.currentState!.validate())) {
      return;
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await userStateController.checkForgotPasswordEmail(
          userStateController.email.value.trim(),
        );
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 116, 255, 121),
              content: Text(
                "Email ${userStateController.email.value} successfully verified.",
                style: TextStyle(
                  color: Color(0xFF202020),
                  fontSize: 14,
                  fontFamily: "DM Sans",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        // call the userstatecontroller with the already gotten phone number
        if (mounted) {
          userStateController.triggerUserForgotPasswordOtp(
              userStateController.phoneNumber.value, context);
        }
        if (mounted) {
          Navigator.pushNamed(context, '/reset_password_otp');
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 255, 63, 49),
              content: Text(
                "Error: $e",
                style: TextStyle(
                  color: Color(0xFF202020),
                  fontSize: 14,
                  fontFamily: "DM Sans",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // build method for the forgot password page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5C147),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Stack(children: [
          // Back button at the top-left
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
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your eamil address to reset password',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF606060),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff202020),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  TextFormField(
                    onChanged: (validatedEmail) {
                      userStateController.email.value = validatedEmail;
                    },
                    validator: (validateEmail) {
                      const String emailPattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      final RegExp emailRegExp = RegExp(emailPattern);
                      if (validateEmail == null || validateEmail.isEmpty) {
                        return 'Please enter your email';
                      } else if (!emailRegExp.hasMatch(validateEmail)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                  const SizedBox(height: 60),
                  _isLoading
                      ? Center(child: const CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _sendPasswordResetEmail,
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(
                                const Size(double.infinity, 50)),
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return const Color(0xFF505050);
                                }
                                return const Color(0xff2D2D2D);
                              },
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 100)),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DM Sans',
                                color: Color(0xFFFFFFFF)),
                          ),
                        ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Obx(() => Center(
                        child: Text(
                          userStateController.createAccountMessage.value,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 52, 38),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          )
        ]),
      )),
    );
  }
}
