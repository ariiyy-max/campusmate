import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  // Track which item is expanded
  int? _expandedIndex;

  // FAQ data
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: "How I Find roommates?",
      answer: "Open the homepage go to the booking to select your room and get also can get friend",
    ),
    FAQItem(
      question: "How do I reset my password?",
      answer: "Open the Login screen\nTap Forgot Password\nEnter your registered email\nCheck your email for the reset link\nCreate a new password",
    ),
    FAQItem(
      question: "Can I edit my preferences?",
      answer: "Yes.\nGo to:\nProfile → Preferences → Edit",
    ),
    FAQItem(
      question: "Where can I find my playlists?",
      answer: "Nowhere. There are no playlists. Go and use your 'favorite Spoodify' that has all the features you want, alright? Learn more",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // ✅ Same background style as your previous screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wave_bg.png'), // same background
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // ✅ Header
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
                    Expanded(
                      child: Text(
                        "F.A.Q.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // balance back arrow
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),

            // ✅ FAQ List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: _faqItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 30),
                itemBuilder: (context, index) {
                  final item = _faqItems[index];
                  final isExpanded = _expandedIndex == index;

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A3A5F), // dark blue card
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        // Question Row
                        InkWell(
                          onTap: () {
                            setState(() {
                              _expandedIndex = isExpanded ? null : index;
                            });
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.question,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Arrow Icon
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.4),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: Icon(
                                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                    color: const Color(0xFF6A359C),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Answer Section (Expandable)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: isExpanded ? null : 0,
                          child: isExpanded
                              ? Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 100,
                              bottom: 16,
                            ),
                            child: Text(
                              item.answer,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                height: 1.4,
                              ),
                            ),
                          )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Model class for FAQ items
class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
