import 'package:flutter/material.dart';
import 'package:campusmate/personal_setup.dart';
import 'package:campusmate/Loginorsignup/Phonescreen.dart';
import 'package:campusmate/Loginorsignup/Emailscreen.dart';
import 'package:campusmate/main_navigation.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}
class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.trim().isNotEmpty &&
          _emailController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty &&
          _confirmController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

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
            colors:[
              Color(0xFF090A21),
              Color(0xFF26084D),
              Color(0xFF75056B),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Text(
                'Create New Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 30),

              _buildLabel('Your Full Name'),
              _buildTextField(
                controller: _nameController,
                hintText: 'Your Full Name',
              ),
              const SizedBox(height: 12),

              _buildLabel('Email'),
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 12),

              _buildLabel('Password'),
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                isPassword: true,
              ),
              const SizedBox(height: 12),

              _buildLabel('Confirm Password'),
              _buildTextField(
                  controller: _confirmController,
                  hintText: 'Confirm Password',
                  isPassword: true
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Phonescreen()));
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(color: const Color(0xFF1E272C), borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.phone, color: Colors.white, size: 18),
                      SizedBox(width: 10),
                      Text('Login with Phone', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const EmailScreen()));
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.g_mobiledata, color: Colors.red, size: 30),
                      SizedBox(width: 5),
                      Text('Login with Google', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text("Login", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid? const Color(0xFF7848B6) : const Color(0xFF7848B6).withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      elevation: _isFormValid ? 2:0,
                    ),
                    onPressed: _isFormValid? () {
                      print("Register clicked!");
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const MainNavigationScreen()),
                      );
                    }
                        : null,
                    child: Text('Register',style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: _isFormValid? Colors.white : Colors.white30,
                    ),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 4),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  static Widget _buildTextField(
      {required TextEditingController controller,
        required String hintText,
        bool isPassword = false,
      }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}