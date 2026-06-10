import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _NamecardScreenState(); // ✅ Added missing createState
}

class _NamecardScreenState extends State<HelpCenter> { // ✅ Added State class
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

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                    const Expanded(
                      child: Text(
                        "Help Center",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),


            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Need help?",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const Text(
                      "Talk to us!",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),

                    const SizedBox(height: 40),


                    Center(
                      child: Image.asset(
                        "images/help_icon.png",
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),


                    const Text(
                      "Alternatively, call us on (05-7732311) or email us sys.support@usas.edu.my on for further assistance",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF757575), fontSize: 20, height: 1.4),
                    ),

                    const SizedBox(height: 110),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6A359C),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  elevation: 0,
                                ),
                                child: const Text("Call Now", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE0E0E0),
                                  foregroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  elevation: 0,
                                ),
                                child: const Text("Send Email", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}