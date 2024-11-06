import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5C147),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 160),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "DM Sans",
                        color: Color(0xff202020),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFEE5E5),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Favour Akinwande',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff202020),
                    fontFamily: "DM Sans",
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            Container(
              width: 279,
              height: 50,
              padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 143,
                    height: 34,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDEACB),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Text(
                      'Are you a vendor?',
                      style: TextStyle(
                        color: Color(0xff212121),
                        fontSize: 14,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/splash_store');
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Set up store',
                            style: TextStyle(
                              color: Color(0xff606060),
                              fontSize: 14,
                              fontFamily: "DM Sans",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 16,
                            color: Color(0xff202020),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.06,
                    left: 16,
                    right: 16,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4F9),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Icon1.user_edit,
                            title: 'Edit Profile',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color(0xff7D7F88),
                            thickness: 0.25,
                          ),
                          _buildMenuItem(
                            icon: Icon1.lock,
                            title: 'Security',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color(0xff7D7F88),
                            thickness: 0.25,
                          ),
                          _buildMenuItem(
                            icon: Iconify1.location,
                            title: 'Addresses',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color(0xff7D7F88),
                            thickness: 0.25,
                          ),
                          _buildMenuItem(
                            icon: Icon1.call,
                            title: 'Contact Us',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color(0xff7D7F88),
                            thickness: 0.25,
                          ),
                          _buildMenuItem(
                            icon: Icon1.message_question,
                            title: 'FAQs',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color(0xff7D7F88),
                            thickness: 0.25,
                          ),
                          _buildMenuItem(
                            icon: Icon1.export_icon,
                            title: 'Log Out',
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            textColor: const Color(0xffF8474A),
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
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(200),
        ),
        child: Icon(icon, color: textColor ?? const Color(0xff202020)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w500,
          color: textColor ?? const Color(0xff202020),
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xff808080),
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
