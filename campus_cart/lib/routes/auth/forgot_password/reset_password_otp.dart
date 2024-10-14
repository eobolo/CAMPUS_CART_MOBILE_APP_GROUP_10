import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class OtpResetPassword extends StatefulWidget {
  const OtpResetPassword({super.key});

  @override
  _OtpResetPasswordState createState() => _OtpResetPasswordState();
}

class _OtpResetPasswordState extends State<OtpResetPassword> {
  final TextEditingController otpController = TextEditingController();
  bool isButtonDisabled = true;

  void _checkOtpInput() {
    if (otpController.text.length == 5) {
      setState(() {
        isButtonDisabled = false;
      });
    } else {
      setState(() {
        isButtonDisabled = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    otpController.addListener(_checkOtpInput);
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _submitOtp() {
    // Implement OTP verification logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5C147),
      body: SafeArea(
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
                  'Enter OTP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM Sans',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We sent a secret code to your email - ade....ba@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF606060),
                    fontWeight: FontWeight.normal,
                    fontFamily: 'DM Sans',
                  ),
                ),
                const SizedBox(height: 35),

                const Text(
                  'Enter otp',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff202020),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM Sans',
                  ),
                ),

                const SizedBox(height: 10),

                // OTP input field
                Pinput(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  length: 5,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  obscureText: otpController.text.length == 5,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 40,
                      color: Color(0xff909090),
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onChanged: (value) {
                    _checkOtpInput();
                    setState(() {});
                    if (value.length == 5) {
                      _submitOtp();
                    }
                  },
                ),

                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: isButtonDisabled ? null : _submitOtp,
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 60)),
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return const Color(0xFF505050);
                        }
                        return const Color(0xff2D2D2D);
                      },
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
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
              ],
            ),
          ),
        )
      ])),
    );
  }
}
