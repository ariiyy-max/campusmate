import 'package:flutter/material.dart';
import 'loginorsignup/Signupscreen.dart';
import 'chat.dart'; // Changed from 'chatscreen.dart' to 'chat.dart'

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F0C31),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0F0C31)),
      ),
      home: const HomeScreen(),
    );
  }
}

class UserProfile {
  final String name;
  final int age;
  final String major;
  final String assetPath;
  UserProfile({
    required this.name,
    required this.age,
    required this.major,
    required this.assetPath,
  });
}

class FilterOptions {
  String? course;
  String? ageRange;

  FilterOptions({this.course, this.ageRange});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isFindMatchSelected = true;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  FilterOptions _currentFilter = FilterOptions();

  final List<UserProfile> _allProfiles = [
    UserProfile(name: "Mia", age: 27, major: "Information Technology", assetPath: "assets/avatar1.png"),
    UserProfile(name: "Lexa", age: 19, major: "Information Technology", assetPath: "assets/avatar2.png"),
    UserProfile(name: "Silvia", age: 19, major: "Business", assetPath: "assets/avatar3.png"),
    UserProfile(name: "Alice", age: 20, major: "Multimedia", assetPath: "assets/avatar4.png"),
    UserProfile(name: "Sarah", age: 22, major: "Counseling", assetPath: "assets/avatar1.png"),
    UserProfile(name: "Nina", age: 24, major: "Accountant", assetPath: "assets/avatar2.png"),
    UserProfile(name: "Dina", age: 21, major: "Landscape", assetPath: "assets/avatar3.png"),
    UserProfile(name: "Fathia", age: 19, major: "Pendidikan Islam", assetPath: "assets/avatar4.png"),
    UserProfile(name: "Zahra", age: 23, major: "Syariah", assetPath: "assets/avatar1.png"),
  ];

  List<UserProfile> activeProfiles = [];
  List<UserProfile> historyProfiles = [];
  Set<String> sentRequests = {};

  List<UserProfile> getFilteredActiveProfiles() {
    List<UserProfile> filtered = List.from(activeProfiles);
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((profile) =>
          profile.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    if (_currentFilter.course != null && _currentFilter.course!.isNotEmpty) {
      filtered = filtered.where((profile) =>
      profile.major == _currentFilter.course).toList();
    }
    if (_currentFilter.ageRange != null) {
      filtered = filtered.where((profile) {
        final age = profile.age;
        if (_currentFilter.ageRange == '18-20') return age >= 18 && age <= 20;
        if (_currentFilter.ageRange == '21-25') return age >= 21 && age <= 25;
        return true;
      }).toList();
    }
    return filtered;
  }

  List<UserProfile> getFilteredHistoryProfiles() {
    List<UserProfile> filtered = List.from(historyProfiles);
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((profile) =>
          profile.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    if (_currentFilter.course != null && _currentFilter.course!.isNotEmpty) {
      filtered = filtered.where((profile) =>
      profile.major == _currentFilter.course).toList();
    }
    if (_currentFilter.ageRange != null) {
      filtered = filtered.where((profile) {
        final age = profile.age;
        if (_currentFilter.ageRange == '18-20') return age >= 18 && age <= 20;
        if (_currentFilter.ageRange == '21-25') return age >= 21 && age <= 25;
        return true;
      }).toList();
    }
    return filtered;
  }

  void _handleReject(UserProfile profile) {
    setState(() {
      activeProfiles.remove(profile);
      if (!historyProfiles.contains(profile)) {
        historyProfiles.add(profile);
      }
    });
  }

  void _handleLike(UserProfile profile) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SendRequestDialog(
        userName: profile.name,
        userMajor: profile.major,
        onRequestSent: () {
          setState(() {
            sentRequests.add(profile.name);
          });
        },
        onMatch: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('It\'s a match! Check your messages.'),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFF8A4FFF),
            ),
          );
        },
        onDialogClose: () {},
      ),
    );
  }

  void _applyFilter(FilterOptions filter) {
    setState(() {
      _currentFilter = filter;
    });
  }

  @override
  void initState() {
    super.initState();
    activeProfiles = List.from(_allProfiles);
    historyProfiles = [];
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<UserProfile> currentList = isFindMatchSelected
        ? getFilteredActiveProfiles()
        : getFilteredHistoryProfiles();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C31),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("CampusMate", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Hello, Maya", style: TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Find your roommate",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push<FilterOptions>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterScreen(
                            currentFilter: _currentFilter,
                          ),
                        ),
                      );
                      if (result != null) {
                        _applyFilter(result);
                      }
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8A4FFF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            Expanded(
              child: currentList.isEmpty
                  ? const Center(child: Text("No profiles found", style: TextStyle(color: Colors.white38)))
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final user = currentList[index];
                  final requestSent = sentRequests.contains(user.name);

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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                user.assetPath,
                                fit: BoxFit.contain,
                                width: 140,
                                errorBuilder: (c, e, s) {
                                  return const Icon(Icons.account_circle, size: 100, color: Colors.white24);
                                },
                              ),
                            ),
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
                            onTap: () => _handleLike(user),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: requestSent ? Colors.grey : Colors.pink,
                              child: Icon(
                                requestSent ? Icons.check : Icons.favorite,
                                color: Colors.white,
                                size: 18,
                              ),
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
          if (index == 3) {
            // Chat tab selected - navigate to ChatScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatScreenWrapper(),
              ),
            ).then((_) {
              // When returning from chat, reset index to keep Home tab selected
              setState(() {
                _currentIndex = 0;
              });
            });
          } else if (index == 4) {
            // Profile tab - navigate to ProfileScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenWrapper(),
              ),
            ).then((_) {
              setState(() {
                _currentIndex = 0;
              });
            });
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
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

// ─── Send Request Dialog ─────────────────────────────────────────────────────

class SendRequestDialog extends StatefulWidget {
  final String userName;
  final String userMajor;
  final VoidCallback onRequestSent;
  final VoidCallback onMatch;
  final VoidCallback onDialogClose;

  const SendRequestDialog({
    super.key,
    required this.userName,
    required this.userMajor,
    required this.onRequestSent,
    required this.onMatch,
    required this.onDialogClose,
  });

  @override
  State<SendRequestDialog> createState() => _SendRequestDialogState();
}

class _SendRequestDialogState extends State<SendRequestDialog> {
  int dialogState = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFF3EEFF), Color(0xFFE5D9FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dialogState == 0) ...[
              const Text(
                "Send Interest",
                style: TextStyle(fontSize: 30, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF8A4FFF),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 15),
              Text(
                widget.userName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Text(
                widget.userMajor,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              Text(
                "Interested to become roommates with ${widget.userName}?",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              _buildPrimaryButton("SEND REQUEST", () {
                setState(() => dialogState = 1);
                widget.onRequestSent();
              }),
              const SizedBox(height: 10),
              _buildSecondaryButton("CANCEL", () {
                widget.onDialogClose();
                Navigator.pop(context);
              }),
            ] else if (dialogState == 1) ...[
              const Text(
                "Request Sent",
                style: TextStyle(fontSize: 30, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF8A4FFF),
                child: Icon(Icons.check, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 15),
              Text(
                widget.userName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Text(
                widget.userMajor,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              const Text(
                "Your roommate request was sent!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                "Wait for ${widget.userName} to accept your request.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 35),
              _buildPrimaryButton("KEEP SWIPING", () {
                final bool isMatch = DateTime.now().millisecondsSinceEpoch % 2 == 0;
                setState(() {
                  dialogState = isMatch ? 2 : 3;
                });
                if (isMatch) {
                  widget.onMatch();
                }
              }),
            ] else if (dialogState == 2) ...[
              const Text(
                "It's a Match!",
                style: TextStyle(fontSize: 32, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFF8A4FFF),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "${widget.userName} likes you too!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 35),
              _buildPrimaryButton("SEND A MESSAGE", () {
                widget.onMatch();
                Navigator.pop(context);
              }),
              const SizedBox(height: 10),
              _buildSecondaryButton("KEEP SWIPING", () {
                widget.onDialogClose();
                Navigator.pop(context);
              }),
            ] else if (dialogState == 3) ...[
              const Text(
                "It's a Bummer",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.black45,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "It's not a match!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 35),
              _buildSecondaryButton("KEEP SWIPING", () {
                widget.onDialogClose();
                Navigator.pop(context);
              }),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD600D6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFD600D6), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Color(0xFFD600D6), fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}

// ─── App Drawer ─────────────────────────────────────────────────────────

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const _DrawerHeader(),
          Expanded(
            child: _DrawerBody(
              onItemTap: (item) {
                Navigator.pop(context);
                _onMenuItemTapped(context, item);
              },
              onLogout: () {
                Navigator.pop(context);
                _onLogout(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onMenuItemTapped(BuildContext context, String item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $item'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Signupscreen()),
              );
            },
            child: const Text('Logout', style: TextStyle(color: Color(0xFF7C4DFF))),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFF6A3FA0),
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 36),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD4B8E0),
                  border: Border.all(color: Colors.white54, width: 2),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.face,
                    size: 40,
                    color: const Color(0xFF6A3FA0),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Maya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'D24316883',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: _WaveClipper(),
            child: Container(
              height: 30,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 8,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white70, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2, 0,
      size.width, size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => false;
}

class _DrawerBody extends StatelessWidget {
  final void Function(String item) onItemTap;
  final VoidCallback onLogout;

  const _DrawerBody({required this.onItemTap, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItem(icon: Icons.person_outline, label: 'Personal information'),
      _MenuItem(icon: Icons.help_outline, label: 'Help center'),
      _MenuItem(icon: Icons.chat_bubble_outline, label: 'F.A.Q'),
      _MenuItem(icon: Icons.settings_outlined, label: 'Settings'),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 20),
      child: Column(
        children: [
          ...items.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DrawerMenuItem(
                icon: item.icon,
                label: item.label,
                onTap: () => onItemTap(item.label),
              ),
            ),
          ),
          const Spacer(),
          _LogoutButton(onTap: onLogout),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  const _MenuItem({required this.icon, required this.label});
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE8E4F0)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: const Color(0xFF7C4DFF)),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF1A1035),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7C4DFF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
        ),
        onPressed: onTap,
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ─── Filter Screen ────────────────────────────────────────────────────────────

class FilterScreen extends StatefulWidget {
  final FilterOptions currentFilter;

  const FilterScreen({super.key, required this.currentFilter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late String? _selectedCourse;
  late String? _selectedAgeRange;

  final List<String> _courses = [
    "Information Technology",
    "Counseling",
    "Multimedia",
    "Accountant",
    "Landscape",
    "Business",
    "Pendidikan Islam",
    "Syariah",
  ];

  final List<String> _ageRanges = [
    "18-20",
    "21-25",
  ];

  @override
  void initState() {
    super.initState();
    _selectedCourse = widget.currentFilter.course;
    _selectedAgeRange = widget.currentFilter.ageRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C31),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Search Filter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Course", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161439),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _courses.map((course) {
                  final isSelected = _selectedCourse == course;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedCourse = null;
                        } else {
                          _selectedCourse = course;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF8A4FFF) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text(course, style: TextStyle(color: isSelected ? Colors.white : Colors.white70)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text("Age", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161439),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: _ageRanges.map((ageRange) {
                  final isSelected = _selectedAgeRange == ageRange;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedAgeRange = null;
                          } else {
                            _selectedAgeRange = ageRange;
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF8A4FFF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Center(
                          child: Text(ageRange, style: TextStyle(color: isSelected ? Colors.white : Colors.white70)),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCourse = null;
                        _selectedAgeRange = null;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white38),
                      ),
                      child: const Center(
                        child: Text("Reset", style: TextStyle(color: Colors.white70)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final filter = FilterOptions(
                        course: _selectedCourse,
                        ageRange: _selectedAgeRange,
                      );
                      Navigator.pop(context, filter);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8A4FFF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Apply Filter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Chat Screen Wrapper ─────────────────────────────────────────────────────

class ChatScreenWrapper extends StatelessWidget {
  const ChatScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatScreen();
  }
}

// ─── Profile Screen Wrapper ──────────────────────────────────────────────────

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C31),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF8A4FFF),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Maya',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'D24316883',
              style: TextStyle(color: Colors.white38, fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildProfileOption(Icons.settings, 'Settings'),
            _buildProfileOption(Icons.help, 'Help Center'),
            _buildProfileOption(Icons.logout, 'Logout', isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, {bool isLogout = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF161439),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(icon, color: isLogout ? Colors.red : const Color(0xFF8A4FFF)),
          title: Text(
            title,
            style: TextStyle(color: isLogout ? Colors.red : Colors.white),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white38),
          onTap: () {
            if (isLogout) {
              // Handle logout if needed
            }
          },
        ),
      ),
    );
  }
}