import 'package:campus_cart/controllers/user_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

// initialize your time in minutes
int timeInMinutes = 3;

class SignUpOtpVerification extends StatefulWidget {
  const SignUpOtpVerification({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpOtpVerificationState createState() => _SignUpOtpVerificationState();
}

class _SignUpOtpVerificationState extends State<SignUpOtpVerification> {
  final TextEditingController otpController = TextEditingController();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  bool isButtonDisabled = true;
  int _counter = timeInMinutes * 60 * 1000;
  String? _otpTimeMessage = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
    otpController.addListener(_checkOtpInput);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      const int hourMilliSeconds = 3600000;
      const int hourSeconds = 3600;
      const int minuteSeconds = 60;

      if (_counter == 0) {
        setState(() {
          _timer?.cancel();
        });
      } else {
        int getMinutesInMilliSeconds = _counter;
        int getHourInSeconds =
            (getMinutesInMilliSeconds * hourSeconds ~/ hourMilliSeconds);
        int getHourInValue = (getHourInSeconds ~/ hourSeconds);
        int getRemainingSeconds;

        if (hourSeconds > getHourInSeconds) {
          getRemainingSeconds = getHourInSeconds;
        } else {
          getRemainingSeconds =
              getHourInSeconds - (hourSeconds * getHourInValue);
        }

        int getMinuteInValue = (getRemainingSeconds ~/ minuteSeconds);
        int getSecondInValue = getRemainingSeconds - (getMinuteInValue * 60);

        setState(() {
          _counter -= 1000;
          _otpTimeMessage =
              "$getHourInValue:$getMinuteInValue:$getSecondInValue";
        });
      }
    });
  }

  void _checkOtpInput() {
    if (otpController.text.length == 6) {
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
  void dispose() {
    otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _submitOtp() {
    // Implement OTP verification logic here
    userStateController.handleOTPVerification(otpController.text, context);
  }

  void _onResendOtp() {
    userStateController.resendOTP(
        userStateController.phoneNumber.value, context);
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
                    'Verify your account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We sent a secret code to your phonenumber - ade....ba@gmail.com',
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
                    length: 6,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    obscureText: otpController.text.length == 6,
                    defaultPinTheme: PinTheme(
                      width: 50,
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
                      if (value.length == 6) {
                        _submitOtp();
                      }
                    },
                  ),

                  const SizedBox(height: 60),
                  _counter == 0
                      ? Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: _onResendOtp,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(30, 45),
                                backgroundColor: const Color(0xFF202020),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                              ),
                              child: const Text(
                                'resend otp',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontFamily: "DM Sans",
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Text(
                            'Resend OTP in $_otpTimeMessage',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF505050),
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                        ),
                  _counter == 0
                      ? SizedBox()
                      : ElevatedButton(
                          onPressed: isButtonDisabled ? null : _submitOtp,
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
                            'Verify Account',
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
                          userStateController.signUpOtpMessage.value,
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
      ),
    );
  }
}
