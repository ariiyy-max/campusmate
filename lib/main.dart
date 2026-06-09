import 'package:campusmate/Registerscreen.dart';
import 'package:flutter/material.dart';
import 'Loginscreen.dart';

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
        // ✅ Set Ubuntu as DEFAULT font for whole app
        fontFamily: 'Ubuntu',
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,

      routes: {
        '/login': (context) => const LoginScreen(),
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
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE040FB), // Bright purple
              Color(0xFF7C4DFF), // Deep purple
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
                  // Add navigation to main screen here
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    // ✅ Explicitly set font (optional here, since default is Ubuntu)
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Illustration Image
                  Image.asset(
                    'images/room_illustration.png',
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),

                  // Title
                  const Text(
                    'Find a Comfortable Room',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold, // ✅ Will use Ubuntu-Bold.ttf
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  const Text(
                    'Find Rooms & Roommate . Explore more friends who match your interests',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                      fontFamily: 'Ubuntu', // ✅ Regular weight
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),

                  // Next Button
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
                        if (_currentPage < 2) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Navigate to main screen when last page
                        }
                      },
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
}