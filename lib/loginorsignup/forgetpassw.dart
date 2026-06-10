import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  // 1. Controller untuk mengawal input Email
  final TextEditingController _emailController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // 2. Pasang listener untuk mengesan setiap kali pengguna menaip
    _emailController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      // Butang aktif hanya jika Email tidak kosong
      _isFormValid = _emailController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
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
            colors: [Color(0xFF0D0614), Color(0xFF3B145A)], // Tema asal CampusMate
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Butang Kembali (Back Arrow)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),

              // Ikon Hiasan Lock/Key
              const Icon(
                Icons.lock_reset_rounded,
                size: 80,
                color: Colors.amber, // Mengikut warna tema CampusMate
              ),
              const SizedBox(height: 20),

              const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),

              const Text(
                'Enter your email address below and we will send you a link to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 40),

              // Email Input Field
              _buildLabel('Email Address'),
              _buildTextField(
                controller: _emailController,
                hintText: 'Enter your email',
              ),
              const SizedBox(height: 30),

              // Butang Send Reset Link
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid
                        ? const Color(0xFF6B42C6)
                        : const Color(0xFF6B42C6).withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: _isFormValid ? 2 : 0,
                  ),
                  onPressed: _isFormValid
                      ? () {
                    // Logik menghantar email hantar di sini
                    print("Reset link sent to: ${_emailController.text}");

                    // Papar notifikasi ringkas kepada pengguna
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reset link sent to ${_emailController.text}'),
                        backgroundColor: const Color(0xFF6B42C6),
                      ),
                    );
                  }
                      : null,
                  child: Text(
                    'Send Reset Link',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isFormValid ? Colors.white : Colors.white30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi helper untuk Label
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

  // Fungsi helper untuk TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
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
}