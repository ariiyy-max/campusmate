import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.notifications, size: 64, color: Colors.white54),
              const SizedBox(height: 16),
              const Text(
                'Notifications',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                'You have no new notifications',
                style: TextStyle(color: Colors.white38, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}