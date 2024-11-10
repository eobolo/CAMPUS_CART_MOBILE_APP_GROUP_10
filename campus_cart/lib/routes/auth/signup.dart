import 'package:campus_cart/controllers/meal_image_controller.dart';
import 'package:campus_cart/controllers/setup_delivery_controller.dart';
import 'package:campus_cart/controllers/setup_operation_controller.dart';
import 'package:campus_cart/controllers/store_logo_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/splashvisuals.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  final StoreLogoStateController storeLogoStateController =
      Get.find<StoreLogoStateController>();
  final SetupOperationController setupOperationController =
      Get.find<SetupOperationController>();
  final SetupDeliveryController setupDeliveryController =
      Get.find<SetupDeliveryController>();
  final MealImageController mealImageController =
      Get.find<MealImageController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;
  bool _passwordVisible = false;

  void _onSignUp() {
    if (!(_formKey.currentState!.validate())) {
      return;
    } else if (!_agreedToTerms) {
      userStateController.createAccountMessage.value = "Please Agree to Terms";
    } else if (!userStateController.iSTermsAndConditionRead.value) {
      userStateController.createAccountMessage.value =
          "Please Go and Read Terms and Conditions";
    } else {
      userStateController.registerUser(
          userStateController.phoneNumber.value, context);
    }
  }

  void _onLogin() {
    Navigator.pushNamed(context, '/login');
  }

  void _onTermsAndCondition() {
    Navigator.pushNamed(context, '/terms_and_conditions');
  }

  void _authWithGoogle() async {
    try {
      await userStateController.signInWithGoogleAndStoreData(context);
      try {
        // do a try and catch for each call so the others doesn't affect the rest.
        // in the future
        // call retrieve logo.
        try {
          await storeLogoStateController
              .retrieveImage(userStateController.loggedInuser?.uid ?? "");
        } catch (e) {
          // do nothing
        }
        // call setupdelivery, operations, payment infos, user dishes.
        try {
          await mealImageController.getAllUserDishes();
        } catch (e) {
          // do nothing
        }
        try {
          await setupDeliveryController.getSetupDeliveryFromDb();
        } catch (e) {
          // do nothing
        }
        try {
          await setupOperationController.getSetupOperationFromDb();
        } catch (e) {
          //do nothing
        }
      } catch (e) {
        // do nothing
      }
      if (mounted) {
        // send user to splash store for now, will change to home later
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      // Handle and show errors
      if (e.toString() == "Exception: campus user deleted") {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: const Color.fromARGB(255, 255, 63, 49),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5C147),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: MediaQuery.of(context).size.height * 0.39,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/bag-happy-bw.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Campus Cart',
                                  style: TextStyle(
                                    color: Splashvisuals.textColor,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Recoleta",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                bottom: MediaQuery.of(context).size.height * 0.0001,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Color(0xFF202020),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "DM Sans",
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Color(0xFF202020),
                                fontSize: 14,
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            GestureDetector(
                              onTap: _onLogin,
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Color(0xFFD49400),
                                  fontSize: 14,
                                  fontFamily: "DM Sans",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Email field
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          onChanged: (validatedEmail) {
                            userStateController.email.value = validatedEmail;
                          },
                          validator: (validateEmail) {
                            const String emailPattern =
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            final RegExp emailRegExp = RegExp(emailPattern);
                            if (validateEmail == null ||
                                validateEmail.isEmpty) {
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
                        const SizedBox(height: 20),

                        // Phone field
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        IntlPhoneField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: '00 000 00000',
                            filled: true,
                            fillColor: const Color(0xFFE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 23.0, horizontal: 40.0),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.normal,
                          ),
                          initialCountryCode: 'RW',
                          onChanged: (phone) {
                            userStateController.phoneNumber.value =
                                phone.completeNumber;
                          },
                          validator: (phone) {
                            if (phone == null || phone.number.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: const Color(0xFF000000),
                          ),
                          dropdownIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xffffffff),
                          ),
                          flagsButtonMargin:
                              const EdgeInsets.only(left: 11, right: 15),
                          flagsButtonPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.phone,
                          dropdownIconPosition: IconPosition.trailing,
                          dropdownTextStyle: const TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password field
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          onChanged: (validatedPassword) {
                            userStateController.password.value =
                                validatedPassword;
                          },
                          validator: (validatePassword) {
                            // Regular expression for password validation
                            final RegExp passwordRegExp = RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                            );
                            if (validatePassword == null ||
                                validatePassword.isEmpty) {
                              return 'Please enter your password';
                            } else if (!passwordRegExp
                                .hasMatch(validatePassword)) {
                              return 'Password must be at least 8 characters long,\ninclude an uppercase letter, a lowercase letter,\na number, and a special character.';
                            }
                            return null; // Return null if valid
                          },
                          controller: passwordController,
                          obscureText: !_passwordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(right: 25),
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
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
                        const SizedBox(height: 8),
                        const Text(
                          'Minimum of 8 characters',
                          style: TextStyle(
                            color: Color(0xFF606060),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Obx(() => Text(
                              userStateController.createAccountMessage.value,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 52, 38),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(height: 15.5),
                        // Terms and conditions checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: (bool? value) {
                                setState(() {
                                  _agreedToTerms = value ?? false;
                                });
                              },
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: _onTermsAndCondition,
                                child: const Text.rich(
                                  TextSpan(
                                    text: 'By signing up, I agree to the ',
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: TextStyle(
                                          color: Color(0xFFD49400),
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Color(0xFFD49400),
                                          decorationThickness: 2,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF505050),
                                    fontSize: 14,
                                    fontFamily: "DM Sans",
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _onSignUp,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 60),
                            backgroundColor: const Color(0xFF202020),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                              fontFamily: "DM Sans",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20),
                              Expanded(
                                child: Divider(
                                  color: Color(0xffC6C6C6),
                                  thickness: 1,
                                ),
                              ),
                              SizedBox(width: 8),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff505050),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'DM Sans',
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Divider(
                                  color: Color(0xffC6C6C6),
                                  thickness: 1,
                                ),
                              ),
                              SizedBox(width: 20),
                            ]),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: _authWithGoogle,
                          icon: Image.asset(
                            'assets/images/google_logo.png',
                            width: 24,
                            height: 24,
                          ),
                          style: OutlinedButton.styleFrom(
                            // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            minimumSize: const Size(double.infinity, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            side: const BorderSide(
                              color: Color(0xffD2D2D2),
                              width: 1,
                            ),
                          ),
                          label: const Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DM Sans',
                              color: Color(0xff202020),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
