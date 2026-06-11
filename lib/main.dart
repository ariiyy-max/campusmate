import 'package:flutter/material.dart';
import 'Loginorsignup/Signupscreen.dart';
import 'homescreen.dart';
import 'chat.dart';
import 'personal_profile.dart';
import 'booking_screen.dart';
import 'notification_screen.dart';
import 'Loginorsignup/Registerscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        fontFamily: 'Ubuntu',
        scaffoldBackgroundColor: const Color(0xFF0F0C31),
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const Signupscreen(),
        '/register': (context) => const Registerscreen(),
        '/home': (context) => const HomeScreen(),
        '/main-nav': (context) => const MainNavigationScreen(),
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

  final List<Map<String, dynamic>> _pages = [
    {
      "image": "images/room_illustration.png",
      "title": "Find a Comfortable Room",
      "desc": "Find Rooms & Roommate. Explore more friends who match your interests",
      "height": 220.0,
    },
    {
      "image": "images/page2_illustration.png",
      "title": "Close Friend Match",
      "desc": "Find Your Ideal Roommate. Our system will match you with friends who share similar sleeping habits, study habits, and hobbies.",
      "height": 400.0,
    },
    {
      "image": "images/page3_illustration.png",
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
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Signupscreen()));
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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              child: Padding(
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
                              _currentPage++;
                            });
                          } else {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => const Signupscreen()));
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

// Main Navigation Screen with Bottom Navigation Bar (5 tabs)
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BookingScreen(),
    const NotificationScreen(),
    const ChatScreen(),
    const PersonalProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0A0724),
        selectedItemColor: const Color(0xFF8A4FFF),
        unselectedItemColor: Colors.white38,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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
      ),
    );
  }
}
