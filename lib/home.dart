import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final int age;
  final String major;
  final String avatarUrl;
  UserProfile({required this.name, required this.age, required this.major, required this.avatarUrl});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isFindMatchSelected = true;

  List<UserProfile> activeProfiles = [
    UserProfile(name: "Mia", age: 27, major: "Information Technology", avatarUrl: "https://i.imgur.com/8Q7ZpY6.png"),
    UserProfile(name: "Lexa", age: 19, major: "Information Technology", avatarUrl: "https://i.imgur.com/K3Z9j90.png"),
    UserProfile(name: "Silvia", age: 19, major: "Business Major", avatarUrl: "https://i.imgur.com/Vb8x8f8.png"),
    UserProfile(name: "Alice", age: 20, major: "Multimedia", avatarUrl: "https://i.imgur.com/K3Z9j90.png"),
  ];

  List<UserProfile> historyProfiles = [];

  void _handleReject(UserProfile profile) {
    setState(() {
      activeProfiles.remove(profile);
      if (!historyProfiles.contains(profile)) {
        historyProfiles.add(profile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<UserProfile> currentList = isFindMatchSelected ? activeProfiles : historyProfiles;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("CampusMate", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("Hello, Maya", style: TextStyle(color: Colors.white60, fontSize: 14)),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  )
                ],
              ),
            ),

            // Search Field Placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Text("Find your roommate", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

            // Navigation Sliding Toggle Button Filter Tab
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1B4E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFindMatchSelected = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isFindMatchSelected ? const Color(0xFF8A4FFF) : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: const Text("Find Match", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFindMatchSelected = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isFindMatchSelected ? const Color(0xFF8A4FFF) : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: const Text("History", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Roommate Profiles List Context View Panel
            Expanded(
              child: currentList.isEmpty
                  ? const Center(child: Text("No profiles found", style: TextStyle(color: Colors.white38)))
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final user = currentList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161439),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 10,
                          bottom: 0,
                          top: 10,
                          child: Opacity(
                            opacity: 0.8,
                            child: Image.network(user.avatarUrl, fit: BoxFit.contain, width: 140, errorBuilder: (c, e, s) {
                              return const Icon(Icons.account_circle, size: 100, color: Colors.white24);
                            }),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${user.name}, ${user.age}", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(user.major, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: GestureDetector(
                            onTap: () => _handleReject(user),
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: GestureDetector(
                            onTap: () {
                              // Action handle hook placeholder for liking profiles
                            },
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.pink,
                              child: Icon(Icons.favorite, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0A0724),
        selectedItemColor: const Color(0xFF8A4FFF),
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}