import 'package:campus_cart/controllers/user_controllers.dart';
import 'package:campus_cart/routes/visuals/splashvisuals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final UserStateController userStateController =
      Get.find<UserStateController>();

  void _backToSignUp() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Splashvisuals.boxDecorationColorB,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container with background replicating the AppBar
          Container(
            width: double.infinity,
            height: 170.0, // Same height as the previous AppBar
            decoration: BoxDecoration(
              color: Splashvisuals.boxDecorationColorB,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 50.0), // Adjust padding
              child: Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Splashvisuals.backGroundColorA,
                    ),
                    child: IconButton(
                      iconSize: 30.0,
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Splashvisuals.boxDecorationColorA,
                      ),
                      onPressed: _backToSignUp,
                    ),
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  Container(
                    width: 55.0,
                    height: 55.0,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/bag-happy.png"))),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Campus Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body content in a scrollable view
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12.0),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Splashvisuals.backGroundColorA,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 8.0, vertical: 14),
                      child: Text(
                        "Terms and Conditions",
                        style: Splashvisuals.textStyle(25.0).copyWith(
                          color: Splashvisuals.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildSectionTitle("1. Introduction"),
                    _buildSectionContent(
                      "Welcome to Campus Cart, a mobile application aimed at creating an efficient platform for students at the African Leadership University (ALU) to conduct business, buy products, and manage their entrepreneurial activities. By accessing or using the Campus Cart app, you agree to comply with and be bound by these Terms and Conditions, along with any other applicable policies or guidelines.",
                    ),
                    _buildSectionTitle("2. Account Registration"),
                    _buildSectionContent(
                      "To use the Campus Cart app, users must create an account. You are responsible for maintaining the confidentiality of your account credentials and agree to notify us immediately of any unauthorized use of your account. You agree that all information provided during registration is accurate and up-to-date.",
                    ),
                    _buildSectionTitle("3. Use of the App"),
                    _buildSectionContent(
                      "You may use the Campus Cart app for lawful purposes only. You agree not to engage in any activity that could harm, disrupt, or interfere with the functionality of the app, including but not limited to hacking, data mining, or introducing harmful code such as viruses.",
                    ),
                    _buildSectionTitle("4. Vendor Responsibilities"),
                    _buildSectionContent(
                      "Vendors are responsible for ensuring that the products they list on the app are lawful, safe, and meet the necessary quality standards. Vendors agree to maintain accurate and up-to-date product listings, including pricing, availability, and descriptions. Vendors also agree to manage their orders and customer interactions in a professional manner.",
                    ),
                    _buildSectionTitle("5. Buyer Responsibilities"),
                    _buildSectionContent(
                      "Buyers agree to use the Campus Cart app to purchase products in good faith and agree to pay for the items they order. Buyers are responsible for ensuring that all necessary payment details are provided correctly.",
                    ),
                    _buildSectionTitle("6. Privacy and Data Collection"),
                    _buildSectionContent(
                      "Campus Cart collects certain personal information from users to provide its services. We are committed to protecting your privacy and will not share your data with third parties without your consent, except as required by law. By using this app, you consent to our privacy policy, which outlines how we collect, use, and store your personal data.",
                    ),
                    _buildSectionTitle("7. Payment and Transactions"),
                    _buildSectionContent(
                      "Payments for products and services purchased on Campus Cart are processed through secure payment gateways. Vendors and buyers are responsible for ensuring that all financial transactions are conducted in a lawful and secure manner. Campus Cart may charge transaction fees for using its platform, which will be disclosed before completing any transaction.",
                    ),
                    _buildSectionTitle("8. Termination and Suspension"),
                    _buildSectionContent(
                      "Campus Cart reserves the right to suspend or terminate your account at its discretion, with or without cause, for violating these Terms and Conditions or for engaging in any behavior that harms the app’s functionality or other users.",
                    ),
                    _buildSectionTitle("9. Limitation of Liability"),
                    _buildSectionContent(
                      "Campus Cart is not responsible for any loss or damage caused by the use of its services, including but not limited to product quality issues, transaction disputes, or data loss. Our liability is limited to the extent permitted by applicable law.",
                    ),
                    _buildSectionTitle("10. Governing Law"),
                    _buildSectionContent(
                      "These Terms and Conditions are governed by the laws of the jurisdiction in which Campus Cart operates. Any disputes arising from the use of this app will be subject to the exclusive jurisdiction of the courts in that jurisdiction.",
                    ),
                    _buildSectionTitle("11. Changes to Terms and Conditions"),
                    _buildSectionContent(
                      "Campus Cart reserves the right to modify these Terms and Conditions at any time. Any changes will be communicated to users through the app or via email, and continued use of the app will be deemed acceptance of the modified terms.",
                    ),
                    _buildSectionTitle("12. Contact Us"),
                    _buildSectionContent(
                      "If you have any questions or concerns regarding these Terms and Conditions or your use of the Campus Cart app, please contact us at e.obolo@alustudent.com .",
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value:
                              userStateController.iSTermsAndConditionRead.value,
                          onChanged: (bool? value) {
                            setState(() {
                              userStateController.iSTermsAndConditionRead
                                  .value = value ?? false;
                            });
                          },
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'I have read all ',
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
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom widget for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Splashvisuals.boxDecorationColorB,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Custom widget for section content
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Text(
        content,
        style: Splashvisuals.textStyle(14.0).copyWith(
          color: Splashvisuals.textColor,
          height: 1.5, // Adjust line height for readability
        ),
      ),
    );
  }
}
