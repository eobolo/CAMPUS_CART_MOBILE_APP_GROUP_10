import 'package:campus_cart/custom_exceptions/otp_different.dart';
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
  bool isBuyer = true;
  RxBool iSTermsAndConditionRead = false.obs;

  // messages for Auth Pages
  RxString createAccountMessage = "".obs;
  RxString signUpOtpMessage = "".obs;

  // Auth details
  // although it is dynamic only Null and User class from firebase auth is stored there
  // this is a perfect way to create reactive variables for databases classes
  dynamic loggedInuser = null.obs;
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
      await Future.delayed(const Duration(seconds: 3));
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
          };
          await _dbRef.child("campusCartUsers").child(user.uid).set(newUser);
          signUpOtpMessage.value =
              "Campus user created successfully with additional info!";
          await Future.delayed(const Duration(seconds: 2));
          if (context.mounted) {
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
  }
}
