import 'package:campus_cart/controllers/user_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class for the reset password page
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordState createState() => _ResetPasswordState();
}

// state class for the reset password page
class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isButtonDisabled = true;

  // function to validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])')
        .hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    } else {
      return null;
    }
  }

  // function to validate confirm password
  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

  // function to check if password is changed
  void _onPasswordChanged() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      // save password in state if validated
      userStateController.password.value = _confirmPasswordController.text;
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  // function to update user password
  void _updateUserPassword() async {
    try {
      // String result = await userStateController
      //     .sendPasswordReset(); // Call the controller method
      // Show success message
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(result), backgroundColor: Colors.green),
      //   );
      // }
      // await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    }
  }

  // build method for the reset password page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5C147),
        body: SafeArea(
          child: Stack(
            children: [
              // Back button at the top-left
              Positioned(
                top: 45,
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
                  top: 110,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Form(
                    key: _formKey,
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
                          const SizedBox(height: 30),
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter your new password',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF606060),
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff202020),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              filled: true,
                              fillColor: const Color(0xFFE5E5E5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 30.0),
                              hintStyle: const TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.normal,
                              ),
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
                            ),
                            onChanged: (_) => _onPasswordChanged(),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff202020),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_confirmPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Confirm your password',
                              filled: true,
                              fillColor: const Color(0xFFE5E5E5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 30.0),
                              hintStyle: const TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.normal,
                              ),
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(right: 25),
                                icon: Icon(_confirmPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            onChanged: (_) => _onPasswordChanged(),
                            validator: _validateConfirmPassword,
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed:
                                _isButtonDisabled ? null : _updateUserPassword,
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(
                                  const Size(double.infinity, 60)),
                              backgroundColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return const Color(0xFF505050);
                                  }
                                  return const Color(0xff2D2D2D);
                                },
                              ),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 100)),
                            ),
                            child: const Text(
                              'Reset Password',
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
                  )),
            ],
          ),
        ));
  }
}
