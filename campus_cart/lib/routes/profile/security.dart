import 'package:campus_cart/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final _formKey = GlobalKey<FormState>();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isButtonDisabled = true;

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

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

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

  void _updateUserPassword() async {
    try {
      await userStateController.loggedInuser
          ?.updatePassword(_confirmPasswordController.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(child: Text("Password updated successfully.")),
              backgroundColor: Colors.green),
        );
      }
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(child: Text("password update failed. $e")),
              backgroundColor: Colors.red),
        );
      }
    }
  }

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
                            'Security Details.',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Password Info',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF606060),
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'new password',
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
                              hintText: 'enter new password',
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
                            'confirm password',
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
                              hintText: 'confirm new password',
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
                              'update security',
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
