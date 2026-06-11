import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0F0C31),
      selectedItemColor: const Color(0xFF8A4FFF),
      unselectedItemColor: Colors.white54,
      currentIndex: currentIndex, // Received from MainScreen
      onTap: onTap,               // Triggers the function in MainScreen
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.book_online),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}