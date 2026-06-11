import 'package:flutter/material.dart';

class BlockedAccountScreen extends StatefulWidget {
  const BlockedAccountScreen({super.key});

  @override
  State<BlockedAccountScreen> createState() => _BlockedAccountScreenState();
}

class _BlockedAccountScreenState extends State<BlockedAccountScreen> {
  // Sample blocked accounts list
  List<Map<String, dynamic>> blockedUsers = [
    {
      "name": "Siliva",
      "avatar": "https://via.placeholder.com/150", // replace with real image URL
    },
  ];

  // Unblock function
  void _unblockUser(int index) {
    setState(() {
      blockedUsers.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User unblocked successfully")),
    );
  }

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

            const SizedBox(height: 40),

            // Title
            const Text(
              "Blocked Accounts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // ✅ If no blocked accounts → show empty state
            if (blockedUsers.isEmpty)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 60,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "No blocked accounts",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              )

            // ✅ If has blocked accounts → show list
            else
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: blockedUsers.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final user = blockedUsers[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          // Profile Picture
                          CircleAvatar(
                            backgroundImage: NetworkImage(user["avatar"]),
                            radius: 22,
                          ),
                          const SizedBox(width: 12),
                          // Name
                          Expanded(
                            child: Text(
                              user["name"],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // Unblock Button
                          ElevatedButton(
                            onPressed: () => _unblockUser(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 1,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                            ),
                            child: const Text("Unblock", style: TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            // Save Change Button
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
                    "Save Change",
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