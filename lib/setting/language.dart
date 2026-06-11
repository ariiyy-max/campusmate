import 'package:flutter/material.dart';

class AppLanguageScreen extends StatefulWidget {
  const AppLanguageScreen({super.key});

  @override
  State<AppLanguageScreen> createState() => _AppLanguageScreenState();
}

class _AppLanguageScreenState extends State<AppLanguageScreen> {
  bool _isExpanded = false; // controls show/hide language list
  String? _selectedLanguage;

  final List<Map<String, String>> _languages = const [
    {'flag': '🇸🇦', 'name': 'Arabic'},
    {'flag': '🇧🇩', 'name': 'Bengali'},
    {'flag': '🇬🇧', 'name': 'English'},
    {'flag': '🇫🇷', 'name': 'French'},
    {'flag': '🇩🇪', 'name': 'German'},
    {'flag': '🇮🇳', 'name': 'Hindi'},
    {'flag': '🇮🇹', 'name': 'Italian'},
    {'flag': '🇯🇵', 'name': 'Japanese'},
    {'flag': '🇮🇩', 'name': 'Javanese'},
    {'flag': '🇰🇷', 'name': 'Korean'},
    {'flag': '🇮🇳', 'name': 'Marathi'},
    {'flag': '🇵🇹', 'name': 'Portuguese'},
    {'flag': '🇷🇺', 'name': 'Russian'},
    {'flag': '🇪🇸', 'name': 'Spanish'},
    {'flag': '🇮🇳', 'name': 'Telugu'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wave_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Purple Header
            Container(
              color: const Color(0x006A359C),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Text(
                        "Settings",
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

            const SizedBox(height: 50),

            // Title
            const Text(
              "App Language",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            // Select Language Button (toggles list)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                width: 400,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD0D7E1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedLanguage ?? "Select Language",
                      style: const TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Language List — SHOWS BELOW SAME SCREEN
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isExpanded ? 591 : 0,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: _languages.map((lang) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedLanguage = lang['name'];
                            _isExpanded = false; // close after select
                          });
                        },
                        child: Row(
                          children: [
                            Text(lang['flag']!, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 12),
                            Text(
                              lang['name']!,
                              style: const TextStyle(fontSize: 18, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const Spacer(),

            // Done Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A359C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 2,
                  ),
                  child: const Text("Done", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}