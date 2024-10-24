import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile Screen',
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFABD23),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                      'assets/images/pics1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Favour Akinwande',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
            Container(
              width: 320, // Increase the width
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), // Rounded corners
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9FFB5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Vendor store created',
                        style: TextStyle(
                          color: Color.fromARGB(255, 16, 16, 16),
                          fontSize: 12, // Increased font size
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        // Action when the button is clicked
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Visit Store',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12, // Increased font size
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 21,
                            color: Colors.black54,
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Icons.person_outline,
                            title: 'Edit Profile',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.1), // Thin line with 10% opacity
                          ),
                          _buildMenuItem(
                            icon: Icons.lock_outline,
                            title: 'Security',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                          _buildMenuItem(
                            icon: Icons.location_on_outlined,
                            title: 'Addresses',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                          _buildMenuItem(
                            icon: Icons.phone_outlined,
                            title: 'Contact Us',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                          _buildMenuItem(
                            icon: Icons.help_outline,
                            title: 'FAQs',
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                          _buildMenuItem(
                            icon: Icons.logout,
                            title: 'Log Out',
                            onTap: () {},
                            textColor: Colors.red,
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
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: textColor ?? Colors.black87),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black54,
      ),
      onTap: onTap,
    );
  }
}
