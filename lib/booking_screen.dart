import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.book_online, size: 64, color: Colors.white54),
              const SizedBox(height: 16),
              const Text(
                'Booking Screen',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your bookings here',
                style: TextStyle(color: Colors.white38, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}