import 'package:campusmate/loginorsignup/Emailscreen.dart';
import 'package:flutter/material.dart';
import 'Registerscreen.dart';
import 'Phonescreen.dart';
import 'Emailscreen.dart';
import 'package:campusmate/homescreen.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
              stops: [0.35,0.73],
              colors: [
              Color(0x330404C4), // #0404C4
              Color(0x44EF05F3), // #EF05F3
            // first colors: [Color(0xFF0D0614), Color(0xFF3B145A)], // Gradient from UI
          ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Image.asset('images/logocampusmate.png', width: 100, height: 100, fit: BoxFit.contain,),
              const SizedBox(height: 10),
              const Text(
                'CampusMate',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              const SizedBox(height: 5),
              const Text(
                "Let's Find Your Perfect Match",
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 30),

              // Username Field
              _buildLabel('Username'),
              _buildTextField(hintText: ''),
              const SizedBox(height: 20),

              // Password Field
              _buildLabel('Password'),
              _buildTextField(hintText: '', isPassword: true),

              // Forgot Password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '//forgetscreen'),
                  child: const Text('Forgot Password?', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 10),

              // Or Login With Divider
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white30)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Or Login With', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  Expanded(child: Divider(color: Colors.white30)),
                ],
              ),
              const SizedBox(height: 20),

              // Social Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Phonescreen()));
                    // Tindakan bila tekan Skip
                  },
                    icon: const Icon(Icons.phone_android, color: Colors.white),
                    label: const Text('Login with Phone'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D245C),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailScreen()));
                  },
                  icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                  label: const Text('Login with Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D245C),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Registerscreen()));
                    },
                    child: const Text("Register", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B42C6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),
                    ),
                    );
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build labels
  static Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 4),
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }

  // Helper widget for matching Text Fields
  static Widget _buildTextField({required String hintText, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Helper widget for Social Login Buttons
  static Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required Color color,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    bool isGoogle = false,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: isGoogle ? 32 : 20),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
