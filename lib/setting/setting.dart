import 'package:campusmate/setting/blocked_account.dart';
import 'package:campusmate/setting/change_password.dart';
import 'package:campusmate/setting/language.dart';
import 'package:campusmate/setting/notification.dart';
import 'package:campusmate/setting/privacy_policy.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wave_bg.png'), // same background as before
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Purple Header
            Container(
              color: const Color(0x006A359C),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Text(
                        "Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // balance back arrow
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // General Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical:30),
              child: Text(
                "General",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
      Transform.translate(
        offset: const Offset(0, -20),
            child:
            _buildSettingItem(
              title: "Language",
              trailing: "English",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AppLanguageScreen()));
              },
            ),
      ),
            // Edit Profile
            Transform.translate(
              offset: const Offset(0, -20),
              child:
              _buildSettingItem(
              title: "Edit Profile",
              onTap: () {
              },
            ),
            ),

            // Notification Settings
            Transform.translate(
              offset: const Offset(0, -20),
              child:
              _buildSettingItem(
              title: "Notification Settings",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationSettingScreen()));
              },
            ),
      ),
            const SizedBox(height: 30),

            // Privacy and security Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Text(
                "Privacy and security",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Change Password
            _buildSettingItem(
              title: "Change Password",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
              },
            ),

            // Privacy Policy
            _buildSettingItem(
              title: "Privacy Policy",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
              },
            ),

            // Blocked accounts
            _buildSettingItem(
              title: "Blocked accounts",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BlockedAccountScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable setting item widget
  Widget _buildSettingItem({
    required String title,
    String? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                if (trailing != null)
                  Text(
                    trailing,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 35),
              ],
            ),
          ],
        ),
      ),
    );
  }
}