import 'package:flutter/material.dart';
import 'drawer.dart';  // ← ADD THIS IMPORT

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  bool _isAvatarExpanded = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),  // Now it works because we imported drawer.dart
      body: Stack(
        children: [
          // Main Scrollable Content
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A0633), Color(0xFF42006A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Custom AppBar with Menu Icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Edit profile coming soon!')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Main Body
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          _buildHeaderSection(),
                          const SizedBox(height: 16),
                          _buildProfileInfoList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dim Overlay when Avatar is Expanded
          if (_isAvatarExpanded)
            GestureDetector(
              onTap: () => setState(() => _isAvatarExpanded = false),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),

          // Popup Large Avatar
          if (_isAvatarExpanded)
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _isAvatarExpanded = false),
                child: Hero(
                  tag: 'avatar-large',
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(32),
                      image: const DecorationImage(
                        image: AssetImage('assets/avatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        // Banner and Avatar Combo
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Avatar with Tap Action
            GestureDetector(
              onTap: () => setState(() => _isAvatarExpanded = true),
              child: Transform.translate(
                offset: const Offset(0, 30),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0A0633),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                    ),
                    // Edit Icon
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 14, color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 40),

        // Name and Handles
        const Text(
          'Maya',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          'Dump | IT',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),

        // About Tab Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'About',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfoList() {
    final infoItems = [
      {'title': 'Course', 'value': 'Diploma Information Technology'},
      {'title': 'Birthday Date', 'value': '25 / 12 / 2007'},
      {'title': 'Sleep Schedule', 'value': 'Night owl'},
      {'title': 'Noise level at night', 'value': 'I\'m the one who making noise'},
      {'title': 'Smoking level', 'value': 'Non-smoker'},
      {'title': 'Consume alcohol', 'value': 'Never'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: infoItems.length,
        itemBuilder: (context, index) {
          return ProfileInfoCard(
            title: infoItems[index]['title']!,
            value: infoItems[index]['value']!,
          );
        },
      ),
    );
  }
}

// Info Card Widget
class ProfileInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfoCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}