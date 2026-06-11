import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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

            const SizedBox(height: 30),

            // Title
            const Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            // Privacy Policy Text (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we're collecting it and how it will be used.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we'll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "We don't share any personally identifiable information publicly or with third-parties, except when required to by law.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Our website may link to external sites that are not operated by us. Please be aware that we have no control over the content and practices of these sites, and cannot accept responsibility or liability for their respective privacy policies.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "You are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some of your desired services.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Your continued use of our website will be regarded as acceptance of our practices around privacy and personal information. If you have any questions about how we handle user data and personal information, feel free to contact us.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            // I Agree Button
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    "I agree with this",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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