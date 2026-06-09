import 'package:flutter/material.dart';

class AlcoholQuestionScreen extends StatefulWidget {
  const AlcoholQuestionScreen({super.key});

  @override
  State<AlcoholQuestionScreen> createState() => _AlcoholQuestionScreenState();
}

class _AlcoholQuestionScreenState extends State<AlcoholQuestionScreen> {
  String? _selectedOption;

  final List<String> _options = [
    'Never',
    'Occasionally',
    'Frequently',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Progress Bar
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      color: const Color(0xFF673AB7), // Darker purple
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      color: const Color(0xFFE1D5F5), // Lighter purple
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'How often do you\nconsume alcohol?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            // Options
            ..._options.map((option) {
              final isSelected = _selectedOption == option;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedOption = option;
                    });
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? const Color(0xFF673AB7) : Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: isSelected ? const Color(0xFFF3E5F5) : Colors.white,
                    ),
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? const Color(0xFF673AB7) : Colors.black87,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            // Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedOption != null ? () {
                    // Navigate to next screen
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    disabledBackgroundColor: const Color(0xFFAFAFAF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
