import 'package:flutter/material.dart';
import 'dart:io';
import 'package:campusmate/drawer%20content/user_data.dart';

// ✅ This class holds ALL user data — shared between all screens
class UserProfile {
  static String? fullName;
  static String? nickname;
  static String? email;
  static String? phone;
  static String? age;
  static String? state;
  static String? course;
  static String? matrixNo;
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // ✅ Controllers — auto-fill with saved data
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _matrixController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _ageController;
  late final TextEditingController _stateController;
  late final TextEditingController _courseController;

  @override
  void initState() {
    super.initState();
    // Load existing data into fields
    _nameController = TextEditingController(text: UserProfile.fullName ?? "");
    _usernameController = TextEditingController(text: UserProfile.nickname ?? "");
    _matrixController = TextEditingController(text: UserProfile.matrixNo ?? "");
    _emailController = TextEditingController(text: UserProfile.email ?? "");
    _phoneController = TextEditingController(text: UserProfile.phone ?? "");
    _ageController = TextEditingController(text: UserProfile.age ?? "");
    _stateController = TextEditingController(text: UserProfile.state ?? "");
    _courseController = TextEditingController(text: UserProfile.course ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _matrixController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _stateController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  // ✅ Save all changes
  void _saveChanges() {
    UserProfile.fullName = _nameController.text.trim();
    UserProfile.nickname = _usernameController.text.trim();
    UserProfile.matrixNo = _matrixController.text.trim();
    UserProfile.email = _emailController.text.trim();
    UserProfile.phone = _phoneController.text.trim();
    UserProfile.age = _ageController.text.trim();
    UserProfile.state = _stateController.text.trim();
    UserProfile.course = _courseController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Changes saved successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wave_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column( // ← Top-level Column to split fixed header + scrollable content
          children: [
            // ✅ FIXED HEADER — stays in place
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                    Expanded( // ✅ This Expanded is INSIDE Row — safe!
                      child: Text(
                        "Edit Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),

            // ✅ SCROLLABLE AREA — takes remaining space
            Expanded( // ← This makes scroll fill the rest of the screen
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        child: Row(
                          children: [
                            const SizedBox(width: 40),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -30),

                      // ✅ Profile Picture
                      child: Center(
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: UserData.profileImagePath != null
                              ? FileImage(File(UserData.profileImagePath!))
                              : null,
                          child: UserData.profileImagePath == null
                              ? const Icon(Icons.person, size: 45, color: Colors.grey)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // ✅ Name Field
                    _buildField(
                      label: "Name",
                      hint: "Your Name",
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),

                    // ✅ Username Field
                    _buildField(
                      label: "Username",
                      hint: "Nickname",
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 16),

                    // ✅ Matrix Number
                    _buildField(
                      label: "Matrix Number",
                      hint: "Matrix No.",
                      controller: _matrixController,
                    ),
                    const SizedBox(height: 16),

                    // ✅ Email
                    _buildField(
                      label: "Email",
                      hint: "Example@gmail.com",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // ✅ Phone Number
                    _buildField(
                      label: "Phone number",
                      hint: "+60 00-0000 0000",
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    // ✅ Course
                    _buildField(
                      label: "Course",
                      hint: "Your Course",
                      controller: _courseController,
                    ),
                    const SizedBox(height: 16),

                    // ✅ Age
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Age :", style: TextStyle(fontSize: 15, color: Colors.black54)),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 120,
                          child: TextField(
                            controller: _ageController,
                            decoration: InputDecoration(
                              hintText: "**",
                              hintStyle: const TextStyle(color: Colors.black26),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ✅ State
                    _buildField(
                      label: "State:",
                      hint: "Selangor",
                      controller: _stateController,
                    ),
                    const SizedBox(height: 40),

                    // ✅ Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A359C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Reusable field widget to reduce duplicate code
  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, color: Colors.black54)),
        const SizedBox(height: 6),

        SizedBox(width: 380,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black26),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}