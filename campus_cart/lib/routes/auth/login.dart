import 'package:campus_cart/controllers/all_dishes_controller.dart';
import 'package:campus_cart/controllers/all_users_controller.dart';
import 'package:campus_cart/controllers/meal_image_controller.dart';
import 'package:campus_cart/controllers/setup_delivery_controller.dart';
import 'package:campus_cart/controllers/setup_operation_controller.dart';
import 'package:campus_cart/controllers/store_logo_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/visuals/splashvisuals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// This is the sign in page
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

// This is the state of the sign in page
class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
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
  final AllUsersController allUsersController = Get.find<AllUsersController>();
  final AllDishesController allDishesController =
      Get.find<AllDishesController>();
  final _formSignInKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _passwordVisible = false;

  // This function is called when the user clicks on the create
  void _onSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  // put validation in forms using validator, use onchange to store and update
  // user state controller password, email submit details auth and give responses
  // based on results i.e failure or successmar
  void _onLogin() async {
    if (!(_formSignInKey.currentState!.validate())) {
      return;
    } else {
      setState(() {
        isLoading = true; // to make circular loading action
      });
      try {
        // call firebase Auth method to login
        await userStateController.loginUser(
          userStateController.email.value.trim(),
          userStateController.password.value.trim(),
        );

        setState(() {
          isLoading =
              false; // remove circular loading action incase user navigates there again
        });
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
          try {
            await allUsersController.fetchInitialData();
          } catch (e) {
            //do nothing
          }
          try {
            await allDishesController.fetchInitialData();
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
        setState(() {
          isLoading =
              false; // remove circular loading action since error occured
        });
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
        try {
          await allUsersController.fetchInitialData();
        } catch (e) {
          //do nothing
        }
        try {
          await allDishesController.fetchInitialData();
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

  void _onForgotPassword() async {
    // normally I should be directed to the forgot email page
    // then inside there I get email and do this exact process there
    // not here if alhassan as sent the code
    Navigator.pushNamed(context, '/forget_password');
  }

  // This is the build method for the sign in page
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/bag-happy-bw.png"),
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
                    key: _formSignInKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans",
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xFF202020),
                                fontSize: 14,
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            GestureDetector(
                              onTap: _onSignUp,
                              child: const Text(
                                'Create Account',
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
                          'Password',
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 14,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: TextButton(
                            // onpress for otp password handle navigation
                            onPressed: _onForgotPassword,
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFFD49400),
                                fontSize: 14,
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        isLoading
                            ? Center(child: const CircularProgressIndicator())
                            : ElevatedButton(
                                // onpressed login validate form and also validate database before redirecting to homepage
                                onPressed: _onLogin,
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
                                  'Log In',
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
            ),
          ],
        ),
      ),
    );
  }
}
