import 'package:campusmate/drawer.dart';
import 'package:flutter/material.dart';
import 'loginorsignup/Signupscreen.dart';
import 'filter_screen.dart';
import 'send_request_dialog.dart';
import 'chat.dart';

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
  bool isFindMatchSelected = true;

  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter options
  FilterOptions _currentFilter = FilterOptions();

  // Original complete list of profiles
  final List<UserProfile> _allProfiles = [
    UserProfile(
      name: "Mia",
      age: 27,
      major: "Information Technology",
      assetPath: "assets/avatar1.png",
    ),
    UserProfile(
      name: "Lexa",
      age: 19,
      major: "Information Technology",
      assetPath: "assets/avatar2.png",
    ),
    UserProfile(
      name: "Silvia",
      age: 19,
      major: "Business",
      assetPath: "assets/avatar3.png",
    ),
    UserProfile(
      name: "Alice",
      age: 20,
      major: "Multimedia",
      assetPath: "assets/avatar4.png",
    ),
    UserProfile(
      name: "Sarah",
      age: 22,
      major: "Counseling",
      assetPath: "assets/avatar1.png",
    ),
    UserProfile(
      name: "Nina",
      age: 24,
      major: "Accountant",
      assetPath: "assets/avatar2.png",
    ),
    UserProfile(
      name: "Dina",
      age: 21,
      major: "Landscape",
      assetPath: "assets/avatar3.png",
    ),
    UserProfile(
      name: "Fathia",
      age: 19,
      major: "Pendidikan Islam",
      assetPath: "assets/avatar4.png",
    ),
    UserProfile(
      name: "Zahra",
      age: 23,
      major: "Syariah",
      assetPath: "assets/avatar1.png",
    ),
  ];

  List<UserProfile> activeProfiles = [];
  List<UserProfile> historyProfiles = [];
  Set<String> sentRequests = {};

  // Filtered active profiles based on search and filter
  List<UserProfile> getFilteredActiveProfiles() {
    List<UserProfile> filtered = List.from(activeProfiles);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (profile) =>
            profile.name.toLowerCase().contains(_searchQuery.toLowerCase()),
      )
          .toList();
    }

    // Apply course filter
    if (_currentFilter.course != null && _currentFilter.course!.isNotEmpty) {
      filtered = filtered
          .where((profile) => profile.major == _currentFilter.course)
          .toList();
    }

    // Apply age filter
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
      filtered = filtered
          .where(
            (profile) =>
            profile.name.toLowerCase().contains(_searchQuery.toLowerCase()),
      )
          .toList();
    }

    if (_currentFilter.course != null && _currentFilter.course!.isNotEmpty) {
      filtered = filtered
          .where((profile) => profile.major == _currentFilter.course)
          .toList();
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
      drawer: const DrawerScreen(),
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
            Text(
              "CampusMate",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Hello, Maya",
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar with Filter Icon
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
                          builder: (context) =>
                              FilterScreen(currentFilter: _currentFilter),
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

            // Navigation Sliding Toggle Button Filter Tab
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
                            color: isFindMatchSelected
                                ? const Color(0xFF8A4FFF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Find Match",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => isFindMatchSelected = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isFindMatchSelected
                                ? const Color(0xFF8A4FFF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "History",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Roommate Profiles List
            Expanded(
              child: currentList.isEmpty
                  ? const Center(
                child: Text(
                  "No profiles found",
                  style: TextStyle(color: Colors.white38),
                ),
              )
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
                                  return const Icon(
                                    Icons.account_circle,
                                    size: 100,
                                    color: Colors.white24,
                                  );
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
                              Text(
                                "${user.name}, ${user.age}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                user.major,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              if (requestSent) ...[
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8A4FFF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    "Request Sent",
                                    style: TextStyle(color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ],
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
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
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
    );
  }
}