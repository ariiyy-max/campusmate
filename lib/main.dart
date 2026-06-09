import 'package:campusmate/loginorsignup/Registerscreen.dart';
import 'package:flutter/material.dart';
import 'loginorsignup/Signupscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roommate Finder',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Ubuntu', // Font Ubuntu untuk keseluruhan app
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,

      routes: {
        '/login': (context) => const Signupscreen(),
        '/register': (context) => const Registerscreen(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  // Senarai kandungan setiap halaman
  final List<Map<String, dynamic>> _pages = [
    {
      "image": "images/room_illustration.png", // Gambar halaman 1
      "title": "Find a Comfortable Room",
      "desc": "Find Rooms & Roommate . Explore more friends who match your interests",
      "height": 220.0,
    },
    {
      "image": "images/page2_illustration.png",
      // Gambar halaman 2 (awak perlu letak gambar ni dalam folder assets)
      "title": "Close Friend Match",
      "desc": "Find Your Ideal Roommate. Our system will match you with friends who share similar sleeping habits, study habits, and hobbies.",
      "height": 400.0,
    },
    {
      "image": "images/page3_illustration.png",
      // Boleh tambah halaman 3 jika perlu
      "title": "Ready to Start",
      "desc": "Join us and find your perfect place and partner to live with.",
      "height": 400.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE040FB),
              Color(0xFF7C4DFF),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Skip Button
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Signupscreen()));
                  // Tindakan bila tekan Skip
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Page View (Untuk tukar halaman)
            // ✅ REMOVED PageView, REPLACED with this code
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500), // fade speed
              transitionBuilder: (child, animation) =>
                  FadeTransition(
                    opacity: animation, // ✅ ONLY fade, NO slide
                    child: child,
                  ),
              child: Padding(
                // key = change when page changes → trigger animation
                key: ValueKey<int>(_currentPage),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _pages[_currentPage]["image"],
                      height: _pages[_currentPage]["height"],
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),

                    Text(
                      _pages[_currentPage]["title"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    Text(
                      _pages[_currentPage]["desc"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),

                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF7C4DFF),
                          size: 28,
                        ),
                        onPressed: () {
                          if (_currentPage < _pages.length - 1) {
                            setState(() {
                              _currentPage++; // ✅ change page directly, NO PageView control
                            });
                          } else {

                            // navigate to main screen here
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}