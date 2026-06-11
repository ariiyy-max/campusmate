import 'package:campusmate/report_block/report.dart';
import 'package:flutter/material.dart';
import 'package:campusmate/report_block/block.dart';

class ReportBlockScreen extends StatelessWidget {
  const ReportBlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // ✅ SAME BACKGROUND as your previous screens
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wave_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [

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
                    Expanded(
                      child: Text(
                        "Report & Block",
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

            const SizedBox(height: 30),

            // ✅ List Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildItem(
                    title: "Report account",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportAccountScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildItem(
                    title: "Report content",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportContentScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildItem(
                    title: "Block account",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlockAccountScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Reusable item widget
Widget _buildItem({required String title, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF4A4A4A),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xFF888888),
            size: 30,
          ),
        ],
      ),
    ),
  );
}