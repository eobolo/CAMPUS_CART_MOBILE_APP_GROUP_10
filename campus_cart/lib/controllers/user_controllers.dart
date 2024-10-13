import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  User? loggedInUser;

  String verificationId = '';
  bool otpSent = false; // Track if OTP has been sent
  DateTime? otpSentTime; // Track when OTP was sent
  final Duration otpValidityDuration =
      const Duration(minutes: 5); // Set OTP validity duration

  // Function to send OTP to the user's phone number
  Future<void> sendOTP(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // do nothing after verification completed
        },
        verificationFailed: (FirebaseAuthException e) {
          createAccountMessage.value = "Verification failed: ${e.message}";
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId; // Store verification ID for later use
          otpSent = true; // Mark OTP as sent
          otpSentTime = DateTime.now(); // Record the time OTP was sent
          createAccountMessage.value = "OTP sent!";
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId; // Store verification ID for later use
        },
      );
    } catch (e) {
      createAccountMessage.value = "Error sending OTP: $e";
    }
  }

  // Function to verify the OTP entered by the user
  Future<bool> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      // Attempt to sign in with the credential
      await _auth.signInWithCredential(credential);
      signUpOtpMessage.value = "OTP verified successfully!";
      // Sign out immediately after verification
      await _auth.signOut();

      return true; // Return true if verification is successful
    } catch (e) {
      signUpOtpMessage.value = "Error verifying OTP: $e";
      return false; // Return false if there was an error
    }
  }

  // Function to register a new user with email and password after verifying OTP
  Future<void> registerUser(String phoneNumber) async {
    try {
      // First, send the OTP for phone number verification
      await sendOTP(phoneNumber);

      // start expiry countdown if otp has been sent this should be and async
      // operation that shouldn't be awaited for 

      // delay for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      createAccountMessage.value =
          "User registration initiated! Please verify your phone number.";

      await Future.delayed(const Duration(seconds: 3));

      // TODO then redirect to OTP page
    } catch (e) {
      createAccountMessage.value = "Error during registration: $e";
    }
  }

  // Function to handle OTP verification and create user in Firebase Authentication & Realtime Database
  Future<void> handleOTPVerification(String otp) async {
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
          loggedInUser = user;
          await _dbRef.child('users/${user.uid}').set({
            'email': email.value,
            'phoneNumber': phoneNumber.value,
            'isBuyer': isBuyer,
          });
          await Future.delayed(const Duration(seconds: 2));
          signUpOtpMessage.value =
              "User created successfully with additional info!";
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
      if (otpSent &&
          otpSentTime != null &&
          DateTime.now().isAfter(otpSentTime!.add(otpValidityDuration))) {
        await Future.delayed(const Duration(seconds: 2));
        signUpOtpMessage.value = "OTP has expired. You can request a new one.";
        otpSent = false; // Reset the OTP sent status
      } else {
        await Future.delayed(const Duration(seconds: 2));
        signUpOtpMessage.value = "Please enter the correct OTP.";
      }
    }
  }

  // Function to resend the OTP if needed
  Future<void> resendOTP(String phoneNumber) async {
    if (!otpSent ||
        (otpSentTime != null &&
            DateTime.now().isAfter(otpSentTime!.add(otpValidityDuration)))) {
      await sendOTP(phoneNumber);
    } else {
      signUpOtpMessage.value =
          "Please wait for the current OTP to expire before requesting a new one.";
    }
  }
}
