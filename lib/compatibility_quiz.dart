import 'package:campusmate/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isValidDate() {
    final dayText = _dayController.text.trim();
    final monthText = _monthController.text.trim();
    final yearText = _yearController.text.trim();

    if (dayText.isEmpty || monthText.isEmpty || yearText.isEmpty) return false;

    final day = int.tryParse(dayText);
    final month = int.tryParse(monthText);
    final year = int.tryParse(yearText);

    if (day == null || month == null || year == null) return false;

    // Month 1-12 only
    if (month < 1 || month > 12) return false;

    // Year max 2026
    if (year < 1900 || year > 2026) return false;

    // Days per month
    if (month == 2) {
      // Leap year check
      final isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      if (isLeap) {
        return day >= 1 && day <= 29;
      } else {
        return day >= 1 && day <= 28;
      }
    } else if ([4, 6, 9, 11].contains(month)) {
      return day >= 1 && day <= 30;
    } else {
      return day >= 1 && day <= 31;
    }
  }

  String? _getErrorText() {
    final dayText = _dayController.text.trim();
    final monthText = _monthController.text.trim();
    final yearText = _yearController.text.trim();

    if (dayText.isEmpty || monthText.isEmpty || yearText.isEmpty) return null;

    final day = int.tryParse(dayText);
    final month = int.tryParse(monthText);
    final year = int.tryParse(yearText);

    if (day == null || month == null || year == null) return "Enter numbers only";
    if (month < 1 || month > 12) return "Month must be 1–12";
    if (year > 2026) return "Year cannot exceed 2026";
    if (year < 1900) return "Year too small";

    if (month == 2) {
      final isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      if (isLeap && (day < 1 || day > 29)) return "Feb has 1–29 days";
      if (!isLeap && (day < 1 || day > 28)) return "Feb has 1–28 days";
    } else if ([4, 6, 9, 11].contains(month)) {
      if (day < 1 || day > 30) return "This month has 1–30 days";
    } else {
      if (day < 1 || day > 31) return "This month has 1–31 days";
    }

    return null;
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                SizedBox(
                  width: double.infinity,
                  height: 3.0,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 3.0,
                        color: const Color(0xFFE8E0F5),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.235,
                        height: 3.0,
                        color: const Color(0xFF5A2E91),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80.0),

                // Title
                const Text(
                  "Your birthday?",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 32.0),

                // Date Input Row: DD / MM / YYYY
                Row(
                  children: [
                    // Day
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        controller: _dayController,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        decoration: const InputDecoration(
                          hintText: "DD",
                          hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
                          counterText: "",
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5A2E91))),
                        ),
                        style: const TextStyle(fontSize: 16),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("/", style: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E))),
                    const SizedBox(width: 8),

                    // Month
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        controller: _monthController,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        decoration: const InputDecoration(
                          hintText: "MM",
                          hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
                          counterText: "",
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5A2E91))),
                        ),
                        style: const TextStyle(fontSize: 16),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("/", style: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E))),
                    const SizedBox(width: 8),

                    // Year
                    SizedBox(
                      width: 90,
                      child: TextFormField(
                        controller: _yearController,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: const InputDecoration(
                          hintText: "YYYY",
                          hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
                          counterText: "",
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5A2E91))),
                        ),
                        style: const TextStyle(fontSize: 16),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Error Text
                if (_getErrorText() != null)
                  Text(
                    _getErrorText()!,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                  ),
                const SizedBox(height: 8),

                // Helper Text
                const Text(
                  "Your profile show your age, not your date of birth.",
                  style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                ),

                const Spacer(),

                // Next Button (only active if valid)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isValidDate()
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GenderScreen()),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A2E91),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      elevation: 0,
                      disabledBackgroundColor: const Color(0xFFB4A7C9),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- SIXTH SCREEN: GENDER (PURPLE BORDER + SINGLE CHOICE) ----------------
class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.282,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "What's your gender?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option: Man
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedGender = "Man"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedGender == "Man" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedGender == "Man" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Man", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option: Woman
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedGender = "Woman"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedGender == "Woman" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedGender == "Woman" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Woman", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button (disabled if no choice)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedGender == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NoiseLevelScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- SEVENTH SCREEN: NOISE LEVEL AT NIGHT (PURPLE BORDER + SINGLE CHOICE) ----------------
class NoiseLevelScreen extends StatefulWidget {
  const NoiseLevelScreen({super.key});

  @override
  State<NoiseLevelScreen> createState() => _NoiseLevelScreenState();
}

class _NoiseLevelScreenState extends State<NoiseLevelScreen> {
  String? selectedNoise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.329,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "How do you feel about noise levels at night?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedNoise = "Need total silence"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedNoise == "Need total silence" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedNoise == "Need total silence" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Need total silence", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedNoise = "Don't mind background noise"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedNoise == "Don't mind background noise" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedNoise == "Don't mind background noise" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Don't mind background noise", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedNoise = "I'm the one who making noise :)"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedNoise == "I'm the one who making noise :)" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedNoise == "I'm the one who making noise :)" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("I'm the one who making noise :)", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedNoise == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SmokingScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- EIGHTH SCREEN: SMOKING (PURPLE BORDER + SINGLE CHOICE) ----------------
class SmokingScreen extends StatefulWidget {
  const SmokingScreen({super.key});

  @override
  State<SmokingScreen> createState() => _SmokingScreenState();
}

class _SmokingScreenState extends State<SmokingScreen> {
  String? selectedSmoking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.376,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "What's your relationship with smoking?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedSmoking = "Non-smoker"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedSmoking == "Non-smoker" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedSmoking == "Non-smoker" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Non-smoker", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedSmoking = "Light smoker"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedSmoking == "Light smoker" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedSmoking == "Light smoker" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Light smoker", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedSmoking = "Regular smoker"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedSmoking == "Regular smoker" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedSmoking == "Regular smoker" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Regular smoker", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 4
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedSmoking = "Heavy smoker"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedSmoking == "Heavy smoker" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedSmoking == "Heavy smoker" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Heavy smoker", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedSmoking == null ? null : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AlcoholScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 9. ALCOHOL CONSUMPTION ----------------
class AlcoholScreen extends StatefulWidget {
  const AlcoholScreen({super.key});

  @override
  State<AlcoholScreen> createState() => _AlcoholScreenState();
}

class _AlcoholScreenState extends State<AlcoholScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → 9/15 = 0.9 (90%)
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.423,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "How often do you consume alcohol?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Never"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Never" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Never" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Never", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Occasionally"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Occasionally" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Occasionally" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Occasionally", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Frequently"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Frequently" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Frequently" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Frequently", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GuestOverScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 10. GUEST OVER FREQUENCY ----------------
class GuestOverScreen extends StatefulWidget {
  const GuestOverScreen({super.key});

  @override
  State<GuestOverScreen> createState() => _GuestOverScreenState();
}

class _GuestOverScreenState extends State<GuestOverScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → 10/15 = ~0.93 (93%)
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "How often do you have a guest over?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Rarely"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Rarely" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Rarely" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Rarely", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Occasionally"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Occasionally" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Occasionally" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Occasionally", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Frequently"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Frequently" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Frequently" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Frequently", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OvernightGuestPolicyScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 11. OVERNIGHT GUEST POLICY ----------------
class OvernightGuestPolicyScreen extends StatefulWidget {
  const OvernightGuestPolicyScreen({super.key});

  @override
  State<OvernightGuestPolicyScreen> createState() => _OvernightGuestPolicyScreenState();
}

class _OvernightGuestPolicyScreenState extends State<OvernightGuestPolicyScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → 11/15 = ~0.96 (96%)
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.517,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "What's your policy on overnight guests?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Not allowed"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Not allowed" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Not allowed" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Not allowed", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "1-2 nights a week is fine"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "1-2 nights a week is fine" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "1-2 nights a week is fine" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("1-2 nights a week is fine", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Open, as long as they are respectful"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Open, as long as they are respectful" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Open, as long as they are respectful" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Open, as long as they are respectful", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CleanlinessRankScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 12. CLEANLINESS RANK ----------------
class CleanlinessRankScreen extends StatefulWidget {
  const CleanlinessRankScreen({super.key});

  @override
  State<CleanlinessRankScreen> createState() => _CleanlinessRankScreenState();
}

class _CleanlinessRankScreenState extends State<CleanlinessRankScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → 12/15 = 1.0 (100%)
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.564,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "How do you rank your cleanliness?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "I clean every single day"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "I clean every single day" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "I clean every single day" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("I clean every single day", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "I clean up before I go to bed"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "I clean up before I go to bed" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "I clean up before I go to bed" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("I clean up before I go to bed", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "I only clean when it gets too messy"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "I only clean when it gets too messy" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "I only clean when it gets too messy" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("I only clean when it gets too messy", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SharedChoresScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 13. SHARED CHORES ----------------
class SharedChoresScreen extends StatefulWidget {
  const SharedChoresScreen({super.key});

  @override
  State<SharedChoresScreen> createState() => _SharedChoresScreenState();
}

class _SharedChoresScreenState extends State<SharedChoresScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → 13/15 = 1.0 (full)
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.611,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "How should we handle shared chores?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Weekly schedule"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Weekly schedule" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Weekly schedule" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Weekly schedule", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Clean as needed"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Clean as needed" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Clean as needed" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Clean as needed", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null ? null : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoommateBorrowScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 14. ROOMMATE BORROW THINGS ----------------
class RoommateBorrowScreen extends StatefulWidget {
  const RoommateBorrowScreen({super.key});

  @override
  State<RoommateBorrowScreen> createState() => _RoommateBorrowScreenState();
}

class _RoommateBorrowScreenState extends State<RoommateBorrowScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → 14/15 = ~0.97 (97%)
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.97,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "Can roommate borrow your things?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Always ask first"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Always ask first" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Always ask first" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Always ask first", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Don't touch my stuff"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Don't touch my stuff" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Don't touch my stuff" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Don't touch my stuff", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StudyVibeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 15. STUDY VIBE ----------------
class StudyVibeScreen extends StatefulWidget {
  const StudyVibeScreen({super.key});

  @override
  State<StudyVibeScreen> createState() => _StudyVibeScreenState();
}

class _StudyVibeScreenState extends State<StudyVibeScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → 15/15 = 1.0 (100%)
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "What is your study vibe?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Completely silence"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Completely silence" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Completely silence" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Completely silence", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Soft background music"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Soft background music" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Soft background music" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Soft background music", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "Group study sessions"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "Group study sessions" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "Group study sessions" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("Group study sessions", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TimeInRoomScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 16. TIME SPEND IN ROOM ----------------
class TimeInRoomScreen extends StatefulWidget {
  const TimeInRoomScreen({super.key});

  @override
  State<TimeInRoomScreen> createState() => _TimeInRoomScreenState();
}

class _TimeInRoomScreenState extends State<TimeInRoomScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar → Full 100%
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                "How much time do you spend in the room?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "I'm rarely in the room"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "I'm rarely in the room" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "I'm rarely in the room" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("I'm rarely in the room", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 2
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "I come and go often"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "I come and go often" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "I come and go often" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("I come and go often", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 12),

              // Option 3
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => selectedOption = "I'm mostly in the room"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                      color: selectedOption == "I'm mostly in the room" ? const Color(0xFF5A2E91) : const Color(0xFFE0E0E0),
                      width: selectedOption == "I'm mostly in the room" ? 1.5 : 1,
                    ),
                  ),
                  child: const Text("I'm mostly in the room", style: TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePictureScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- 17. UPLOAD PROFILE PICTURE ----------------
// Add this import at the very TOP of your file:
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({super.key});

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // ✅ FUNCTION TO PICK PHOTO
  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // open phone gallery
      imageQuality: 80, // reduce size a bit
      maxWidth: 500,
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path); // save image
      });
    }
  }

  // ✅ OPTIONAL: TAKE PHOTO WITH CAMERA
  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 500,
    );
    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              SizedBox(
                width: double.infinity,
                height: 3.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3.0,
                      color: const Color(0xFFE8E0F5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: 3.0,
                      color: const Color(0xFF5A2E91),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Back Arrow
              Transform.translate(
                offset: const Offset(-14, 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
                ),
              ),
              const SizedBox(height: 40),

              // Title
              const Text(
                "Upload your profile picture",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                "We'd love to see you. Upload a photo for your matching journey.",
                style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
              const SizedBox(height: 40),

              // ✅ UPLOAD BOX — CLICKABLE
              Center(
                child: GestureDetector(
                  onTap: _pickFromGallery, // CLICK → OPEN GALLERY
                  // OPTIONAL: LONG PRESS TO OPEN CAMERA
                  onLongPress: _takePhoto,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF5A2E91), width: 1.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover, // fill nicely
                        width: 160,
                        height: 160,
                      ),
                    )
                        : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Color(0xFF5A2E91),
                          size: 36,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Add Photo",
                          style: TextStyle(color: Color(0xFF5A2E91), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // ✅ NEXT BUTTON — ENABLED ONLY WHEN PHOTO ADDED
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedImage == null
                      ? null // disabled
                      : () {
                    // ✅ FINISH / GO TO NEXT PAGE
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile picture saved!")),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2E91),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFB4A7C9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}