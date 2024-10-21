import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(),
            _buildMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Favour Akinwande', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('Vendor Store Created', style: TextStyle(color: Colors.green)),
              ),
              TextButton(
                child: Text('Visit Store →'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {'icon': Icons.edit, 'title': 'Edit Profile'},
      {'icon': Icons.security, 'title': 'Security'},
      {'icon': Icons.location_on, 'title': 'Addresses'},
      {'icon': Icons.contact_support, 'title': 'Contact Us'},
      {'icon': Icons.question_answer, 'title': 'FAQs'},
      {'icon': Icons.logout, 'title': 'Log Out'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          leading: Icon(item['icon'] as IconData),
          // title: Text(item['title'] ?? ''),
          trailing: Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
    );
  }
}