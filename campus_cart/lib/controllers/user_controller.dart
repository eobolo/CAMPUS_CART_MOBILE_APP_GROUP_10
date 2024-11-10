import 'package:campus_cart/custom_exceptions/otp_different.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserStateController extends GetxController {
/*
	AUTHENTICATION: SIGNUP, SIGNIN, FORGOT PASSWORD, OTP and ALL.
*/

  // user details
  RxString email = "".obs;
  RxString password = "".obs;
  RxString phoneNumber = "".obs;
  RxBool iSTermsAndConditionRead = false.obs;
  bool isBuyer = true;

  // messages for Auth Pages
  RxString createAccountMessage = "".obs;
  RxString signUpOtpMessage = "".obs;

  // Auth details
  // although it is dynamic only Null and User class from firebase auth is stored there
  // this is a perfect way to create reactive variables for databases classes
  dynamic loggedInuser = null.obs;
  dynamic userDetailInsecure = null.obs;
  RxMap<dynamic, dynamic> campusCartUser = {}.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  PhoneAuthCredential? credential;

  RxString verificationId = ''.obs;
  RxBool otpSent = false.obs; // Track if OTP has been sent
  DateTime? otpSentTime; // Track when OTP was sent
  final Duration otpValidityDuration =
      const Duration(minutes: 3); // Set OTP validity duration

  // Flag to indicate if in testing mode
  bool isTestingMode = true; // Change this to false to send actual SMS

  void reset() {
    email.value = "";
    password.value = "";
    phoneNumber.value = "";
    iSTermsAndConditionRead.value = false;
    isBuyer = true;
    createAccountMessage.value = "";
    signUpOtpMessage.value = "";
    loggedInuser = null;
    userDetailInsecure = null;
    campusCartUser.value = {};
    verificationId.value = "";
    otpSent.value = false;
  }

  // Function to send OTP to the user's phone number
  Future<void> sendOTP(String phoneNumber, BuildContext context) async {
    try {
      // Normal flow for sending OTP via SMS without automatic verification
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Do nothing here to avoid automatic sign-in
        },
        verificationFailed: (FirebaseAuthException e) {
          createAccountMessage.value = "Verification failed: ${e.message}";
        },
        codeSent: (String verId, int? resendToken) async {
          verificationId.value = verId; // Store verification ID for later use
          otpSent.value = true; // Mark OTP as sent
          otpSentTime = DateTime.now(); // Record when OTP was sent
          createAccountMessage.value = "OTP sent! Please check your messages.";
          // delay for 3 seconds
          await Future.delayed(const Duration(seconds: 3));
          createAccountMessage.value = "";
          if (context.mounted) {
            Navigator.pushNamed(context, '/signup_otp');
          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId; // Store for timeout scenario
        },
      );
    } catch (e) {
      createAccountMessage.value = "Error sending OTP: $e";
    }
  }

  // Function to verify the OTP entered by the user
  Future<bool> verifyOTP(String otp) async {
    String testOtp = "456789";
    try {
      if (isTestingMode) {
        if (otp == testOtp) {
          // ignore: unused_local_variable
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId.value,
            smsCode: otp,
          );
          signUpOtpMessage.value = "OTP verified successfully!";
          await Future.delayed(const Duration(seconds: 2));
          return true;
        } else {
          throw OtpDifferent();
        }
      } else {
        // ignore: unused_local_variable
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        );
        signUpOtpMessage.value = "OTP verified successfully!";
        await Future.delayed(const Duration(seconds: 2));
        return true; // Return true if verification is successful
      }
    } catch (e) {
      signUpOtpMessage.value = "Error verifying OTP: $e";
      return false; // Return false if there was an error
    }
  }

  // Function to register a new user with email and password after verifying OTP
  Future<void> registerUser(String phoneNumber, BuildContext context) async {
    signUpOtpMessage.value = "";
    try {
      // First, send the OTP for phone number verification
      await sendOTP(phoneNumber, context);
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      createAccountMessage.value = "Error during registration: $e";
    }
  }

  // Function to handle OTP verification and create user in Firebase Authentication & Realtime Database
  Future<void> handleOTPVerification(String otp, BuildContext context) async {
    bool isVerified = await verifyOTP(otp);
    if (isVerified) {
      try {
        // Create user account with email and password after successful OTP verification
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email.value,
          password: password.value,
        );

        // After creating the user, store additional info in Realtime Database
        User? user = userCredential.user;

        if (user != null) {
          loggedInuser = user;
          final Map<dynamic, dynamic> newUser = {
            "email": email.value,
            "PhoneNumber": phoneNumber.value,
            "isBuyer": true,
            "buyerId": user.uid,
          };
          await _dbRef.child("campusCartUsers").child(user.uid).set(newUser);
          // add new campus cart user to a reactive variable
          campusCartUser.value = newUser;
          // update sign in otp message
          signUpOtpMessage.value =
              "Campus user created successfully with additional info!";
          await Future.delayed(const Duration(seconds: 2));
          await loginUser(email.value, password.value);
          if (context.mounted) {
            // send user to splash store for now, will change to home later
            Navigator.pushReplacementNamed(context, '/home');
          }
        }
      } catch (e) {
        await Future.delayed(const Duration(seconds: 2));
        signUpOtpMessage.value =
            "Error creating user in Firebase Authentication: $e";
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      signUpOtpMessage.value = "OTP verification failed. Please try again.";

      // Check if OTP has expired and allow resend if needed
      if (otpSent.value &&
          otpSentTime != null &&
          DateTime.now().isAfter(otpSentTime!.add(otpValidityDuration))) {
        await Future.delayed(const Duration(seconds: 2));
        signUpOtpMessage.value = "OTP has expired. You can request a new one.";
        otpSent.value = false; // Reset the OTP sent status
      } else {
        await Future.delayed(const Duration(seconds: 2));
        signUpOtpMessage.value = "Please enter the correct OTP.";
      }
    }
  }

  // Function to resend the OTP if needed
  Future<void> resendOTP(String phoneNumber, BuildContext context) async {
    signUpOtpMessage.value = "";
    if (!otpSent.value ||
        (otpSentTime != null &&
            DateTime.now().isAfter(otpSentTime!.add(otpValidityDuration)))) {
      await registerUser(phoneNumber, context);
      signUpOtpMessage.value = "OTP sent! Please check your messages.";
    } else {
      signUpOtpMessage.value =
          "Please wait for the current OTP to expire before requesting a new one.";
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      loggedInuser = userCredential.user;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
    try {
      final event = await _dbRef
          .child("campusCartUsers/${loggedInuser.uid}")
          .once(DatabaseEventType.value);
      campusCartUser.value = event.snapshot.value as Map<dynamic, dynamic>;
    } catch (e) {
      throw Exception("campus user deleted");
    }
  }

  Future<dynamic> checkForgotPasswordEmail(String email) async {
    final UserStateController userStateController =
        Get.find<UserStateController>();
    HttpsCallable checkEmailExistence =
        FirebaseFunctions.instance.httpsCallable('checkEmailExistence');

    try {
      dynamic result = await checkEmailExistence.call({
        "email": email.trim(), // Pass email as a key-value pair
      });

      // Handle the result
      dynamic data = result.data;

      if (data['exists']) {
        userStateController.email.value = data['email'];
        userStateController.phoneNumber.value = data['phoneNumber'];
        userStateController.userDetailInsecure = data['user'];
        return true; // Email exists
      } else {
        throw Exception("User with email $email doesn't exist.");
      }
    } on FirebaseFunctionsException catch (error) {
      throw Exception("Error occurred: ${error.message}");
    }
  }

  Future<void> sendForgotPasswordOTP(
      String phoneNumber, BuildContext context) async {
    try {
      // Normal flow for sending OTP via SMS without automatic verification
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Do nothing here to avoid automatic sign-in
        },
        verificationFailed: (FirebaseAuthException e) {
          createAccountMessage.value = "Verification failed: ${e.message}";
        },
        codeSent: (String verId, int? resendToken) async {
          verificationId.value = verId; // Store verification ID for later use
          otpSent.value = true; // Mark OTP as sent
          otpSentTime = DateTime.now(); // Record when OTP was sent
          createAccountMessage.value = "OTP sent! Please check your messages.";
          // delay for 3 seconds
          await Future.delayed(const Duration(seconds: 3));
          createAccountMessage.value = "";
          if (context.mounted) {
            Navigator.pushNamed(context, '/reset_password_otp');
          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId; // Store for timeout scenario
        },
      );
    } catch (e) {
      createAccountMessage.value = "Error sending OTP: $e";
    }
  }

  Future<void> triggerUserForgotPasswordOtp(
      String phoneNumber, BuildContext context) async {
    signUpOtpMessage.value = "";
    try {
      // First, send the OTP for phone number verification
      await sendForgotPasswordOTP(phoneNumber, context);
      await Future.delayed(const Duration(seconds: 3));
    } catch (e) {
      createAccountMessage.value = "Error during registration: $e";
    }
  }

  Future<bool> verifyForgotPasswordOTP(String otp) async {
    String testOtp = "456789";
    try {
      if (isTestingMode) {
        if (otp == testOtp) {
          // ignore: unused_local_variable
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId.value,
            smsCode: otp,
          );
          signUpOtpMessage.value = "OTP verified successfully!";
          await Future.delayed(const Duration(seconds: 2));
          return true;
        } else {
          throw OtpDifferent();
        }
      } else {
        // ignore: unused_local_variable
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        );
        signUpOtpMessage.value = "OTP verified successfully!";
        await Future.delayed(const Duration(seconds: 2));
        return true; // Return true if verification is successful
      }
    } catch (e) {
      signUpOtpMessage.value = "Error verifying OTP: $e";
      return false; // Return false if there was an error
    }
  }

  // Function to handle OTP verification and create user in Firebase Authentication & Realtime Database
  Future<void> handleForgotPasswordOTPVerification(
      String otp, BuildContext context) async {
    bool isVerified = await verifyForgotPasswordOTP(otp);
    if (isVerified) {
      if (context.mounted) {
        Navigator.pushNamed(context, '/reset_password');
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      signUpOtpMessage.value = "OTP verification failed. Please try again.";

      // Check if OTP has expired and allow resend if needed
      if (otpSent.value &&
          otpSentTime != null &&
          DateTime.now().isAfter(otpSentTime!.add(otpValidityDuration))) {
        await Future.delayed(const Duration(seconds: 2));
        signUpOtpMessage.value = "OTP has expired. You can request a new one.";
        otpSent.value = false; // Reset the OTP sent status
      } else {
        await Future.delayed(const Duration(seconds: 2));
        signUpOtpMessage.value = "Please enter the correct OTP.";
      }
    }
  }

  Future<void> resendForgotPasswordOTP(
      String phoneNumber, BuildContext context) async {
    signUpOtpMessage.value = "";
    if (!otpSent.value ||
        (otpSentTime != null &&
            DateTime.now().isAfter(otpSentTime!.add(otpValidityDuration)))) {
      await triggerUserForgotPasswordOtp(phoneNumber, context);
      signUpOtpMessage.value = "OTP sent! Please check your messages.";
    } else {
      signUpOtpMessage.value =
          "Please wait for the current OTP to expire before requesting a new one.";
    }
  }

  Future<dynamic> sendPasswordReset() async {
    final UserStateController userStateController =
        Get.find<UserStateController>();
    try {
      await _auth.sendPasswordResetEmail(
          email: userStateController.email.value.trim());
      return "Password reset email sent successfully. redirect to login";
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      if (e.code == 'user-not-found') {
        throw Exception("No user found for that email.");
      } else if (e.code == 'invalid-email') {
        throw Exception("The email address is not valid.");
      } else {
        throw Exception("An error occurred: ${e.message}");
      }
    } catch (e) {
      // Handle any other exceptions
      throw Exception("An unexpected error occurred: $e");
    }
  }

  Future<void> updateCampusUserData(String vendorName, String address,
      String city, String storeDetails, String uuid) async {
    final dbRef = _dbRef.child("campusCartUsers").child(uuid);
    final Map<String, Object> addedUserData = {
      "isVendor": true,
      "vendorName": vendorName,
      "address": address,
      "city": city,
      "storeDetails": storeDetails,
    };

    try {
      await dbRef.update(addedUserData);
    } on FirebaseException catch (e) {
      // Handle Firebase Database errors
      switch (e.code) {
        case 'permission-denied':
          throw Exception('Permission denied: ${e.message}');
        case 'disconnected':
          throw Exception('Disconnected from the database: ${e.message}');
        case 'invalid-argument':
          throw Exception('Invalid argument: ${e.message}');
        default:
          throw Exception('Database error: ${e.message}');
      }
    } catch (e) {
      // Handle general errors
      throw Exception('An error occurred: $e');
    }
  }
}
