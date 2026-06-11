import 'package:campusmate/compatibility_quiz.dart';
import 'package:flutter/material.dart';

// ✅ CORRECT MODEL CLASS - NO CONFLICTS NOW
class UserProfileAbout {
  final String course;
  final String birthday;
  final String sleepSchedule;
  final String noiseLevel;
  final String smoking;
  final String alcohol;
  final String? profileImagePath;

  const UserProfileAbout({
    required this.course,
    required this.birthday,
    required this.sleepSchedule,
    required this.noiseLevel,
    required this.smoking,
    required this.alcohol,
    this.profileImagePath,
  });

  // Default empty state
  factory UserProfileAbout.empty() => const UserProfileAbout(
    course: 'Not set yet',
    birthday: 'Not set yet',
    sleepSchedule: 'Not set yet',
    noiseLevel: 'Not set yet',
    smoking: 'Not set yet',
    alcohol: 'Not set yet',
  );
}

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  bool _isAvatarExpanded = false;

  // ✅ USE THE CORRECT MODEL NAME
  UserProfileAbout _userProfile = UserProfileAbout.empty();

  @override
  void initState() {
    super.initState();
    _loadDefaultData();
  }

  // Load initial data (replace this later with saved data from database/storage)
  void _loadDefaultData() {
    setState(() {
      _userProfile = const UserProfileAbout(
        course: 'Diploma Information Technology',
        birthday: '25 / 12 / 2007',
        sleepSchedule: 'Night owl',
        noiseLevel: 'I\'m the one making noise',
        smoking: 'Non-smoker',
        alcohol: 'Never',
      );
    });
  }

  // ✅ UPDATE PROFILE WHEN DATA COMES BACK FROM QUIZ
  void updateProfileData(UserProfileAbout newData) {
    setState(() {
      _userProfile = newData;
    });
    // Optional: Save to SharedPreferences or Firestore here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A0633), Color(0xFF42006A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Custom App Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            // Open Drawer if needed
                          },
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () async {
                            // ✅ OPEN QUIZ AND WAIT FOR RESULT
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CompatibilityQuizScreen(),
                              ),
                            );

                            // ✅ UPDATE PROFILE IF DATA RECEIVED
                            if (result is UserProfileAbout) {
                              updateProfileData(result);
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  // Main Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          _buildHeaderSection(),
                          const SizedBox(height: 16),
                          _buildProfileInfoList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dim Background when Avatar is Clicked
          if (_isAvatarExpanded)
            GestureDetector(
              onTap: () => setState(() => _isAvatarExpanded = false),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),

          // Expanded Avatar Popup
          if (_isAvatarExpanded)
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _isAvatarExpanded = false),
                child: Hero(
                  tag: 'avatar-large',
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(32),
                      image: const DecorationImage(
                        image: AssetImage(
                            'assets/images/profilepersonjpeg-removebg-preview.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Header Section with Avatar and Banner
  Widget _buildHeaderSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Banner Image
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/backdrawer.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Avatar
            GestureDetector(
              onTap: () => setState(() => _isAvatarExpanded = true),
              child: Transform.translate(
                offset: const Offset(0, 30),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0A0633),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                            'assets/images/profilepersonjpeg-removebg-preview.png'),
                      ),
                    ),
                    // Edit Badge
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 14, color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 40),

        // Name & Details
        const Text(
          'Maya',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          'Dump | IT',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),

        // About Tab
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'About',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Profile Information List
  Widget _buildProfileInfoList() {
    // ✅ DATA IS DYNAMICALLY TAKEN FROM _userProfile
    final infoItems = [
      {'title': 'Course', 'value': _userProfile.course},
      {'title': 'Birthday Date', 'value': _userProfile.birthday},
      {'title': 'Sleep Schedule', 'value': _userProfile.sleepSchedule},
      {'title': 'Noise level at night', 'value': _userProfile.noiseLevel},
      {'title': 'Smoking level', 'value': _userProfile.smoking},
      {'title': 'Consume alcohol', 'value': _userProfile.alcohol},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: infoItems.length,
        itemBuilder: (context, index) {
          return RoommateProfileInfoCard(
            title: infoItems[index]['title']!,
            value: infoItems[index]['value']!,
          );
        },
      ),
    );
  }
}

// Reusable Info Card Widget
class RoommateProfileInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const RoommateProfileInfoCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}