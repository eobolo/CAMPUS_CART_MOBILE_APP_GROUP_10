import 'package:flutter/material.dart';
import 'package:campus_cart/Routes/visuals/splashvisuals.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5C147),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.39,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Transform.scale(
                          scale: 1.3,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/mesh.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/bag-happy-bw.png'),
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
              top: MediaQuery.of(context).size.height * 0.13,
              left: 0,
              right: 0,
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
                          onTap: () {
                            // Implement your sign-in navigation here
                          },
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
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 14,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
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
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 14,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'e.g 079 252 5896',
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

                    // Password field
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 14,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: GestureDetector(
                            onTap: () {
                              // Implement your password visibility toggle here
                            },
                            child: const Icon(Icons.visibility),
                          ),
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
                    const SizedBox(height: 75),

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
                        const Flexible(
                          child: Text.rich(
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
                                    decorationStyle: TextDecorationStyle.solid,
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _agreedToTerms
                          ? () {
                      }
                          : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 60),
                          backgroundColor: const Color(0xFF202020),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      child: const Text('Create Account')
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
