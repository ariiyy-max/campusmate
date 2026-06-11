import 'package:flutter/material.dart';
import 'services/chat_manager.dart';
import 'models/chat_user_model.dart';
import 'homescreen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedRoomType; // '2' or '4'
  String? selectedRoomNumber;
  final ChatManager _chatManager = ChatManager();

  // Rooms for 2 people
  final List<Map<String, dynamic>> roomsFor2 = [
    {
      'roomNumber': 'AGO-01',
      'facilities': ['2 double decker', '4 locker', '4 table'],
      'occupants': [
        {'name': 'Sophia', 'age': 22, 'major': 'Computer Science', 'bio': 'Quiet and tidy person, loves reading', 'image': 'assets/avatar1.png'},
        {'name': 'Emma', 'age': 21, 'major': 'Business', 'bio': 'Friendly and outgoing, loves coffee', 'image': 'assets/avatar2.png'},
      ],
    },
    {
      'roomNumber': 'AGO-02',
      'facilities': ['2 double decker', '4 locker', '4 table', 'AC'],
      'occupants': [
        {'name': 'Lisa', 'age': 23, 'major': 'Psychology', 'bio': 'Night owl, loves music', 'image': 'assets/avatar3.png'},
        {'name': 'Anna', 'age': 22, 'major': 'Design', 'bio': 'Creative and artistic', 'image': 'assets/avatar4.png'},
      ],
    },
    {
      'roomNumber': 'AGO-03',
      'facilities': ['2 double decker', '4 locker', '4 table'],
      'occupants': [
        {'name': 'Maya', 'age': 20, 'major': 'Engineering', 'bio': 'Hardworking, loves gym', 'image': 'assets/avatar1.png'},
        {'name': 'Sara', 'age': 21, 'major': 'Medicine', 'bio': 'Studious and organized', 'image': 'assets/avatar2.png'},
      ],
    },
  ];

  // Rooms for 4 people
  final List<Map<String, dynamic>> roomsFor4 = [
    {
      'roomNumber': 'AGO-05',
      'facilities': ['2 double decker', '4 locker', '4 table'],
      'occupants': [
        {'name': 'Mia', 'age': 22, 'major': 'IT', 'bio': 'Tech enthusiast', 'image': 'assets/avatar1.png'},
        {'name': 'Lisa', 'age': 21, 'major': 'Business', 'bio': 'Social butterfly', 'image': 'assets/avatar2.png'},
        {'name': 'Anna', 'age': 23, 'major': 'Design', 'bio': 'Creative mind', 'image': 'assets/avatar3.png'},
        {'name': 'Sara', 'age': 20, 'major': 'Engineering', 'bio': 'Focused and driven', 'image': 'assets/avatar4.png'},
      ],
    },
    {
      'roomNumber': 'AGO-06',
      'facilities': ['2 double decker', '4 locker', '4 table', 'Water heater'],
      'occupants': [
        {'name': 'Zoe', 'age': 22, 'major': 'Psychology', 'bio': 'Good listener', 'image': 'assets/avatar1.png'},
        {'name': 'Nina', 'age': 21, 'major': 'Law', 'bio': 'Ambitious', 'image': 'assets/avatar2.png'},
        {'name': 'Tina', 'age': 23, 'major': 'Medicine', 'bio': 'Caring', 'image': 'assets/avatar3.png'},
        {'name': 'Rina', 'age': 20, 'major': 'Design', 'bio': 'Creative', 'image': 'assets/avatar4.png'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (selectedRoomType == null) {
      return _buildRoomTypeSelection();
    } else if (selectedRoomNumber == null) {
      return _buildRoomList();
    } else {
      return _buildRoomDetail();
    }
  }

  // Step 1: Choose Room Type (Room for 2 or Room for 4)
  Widget _buildRoomTypeSelection() {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Roommate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select the number of occupants you prefer',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),

              // Room for 2 Card
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRoomType = '2';
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1B4E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF8A4FFF), width: 1),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.people_outline,
                        size: 60,
                        color: Color(0xFF8A4FFF),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Room for 2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Perfect for you and a roommate',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Room for 4 Card
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRoomType = '4';
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1B4E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF8A4FFF), width: 1),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.people,
                        size: 60,
                        color: Color(0xFF8A4FFF),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Room for 4',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Great for a group of friends',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
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

  // Step 2: Show available rooms based on selected type
  Widget _buildRoomList() {
    final rooms = selectedRoomType == '2' ? roomsFor2 : roomsFor4;
    final title = selectedRoomType == '2' ? 'Room for 2' : 'Room for 4';

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C31),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              selectedRoomType = null;
            });
          },
        ),
        title: const Text(
          'Select Your Room',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Available $title',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRoomNumber = room['roomNumber'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1B4E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room['roomNumber'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Facilities:',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            children: (room['facilities'] as List<String>).map((facility) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F0C31),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  facility,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.people, size: 14, color: Colors.white54),
                              const SizedBox(width: 4),
                              Text(
                                '${(room['occupants'] as List).length} occupants',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step 3: Show Room Detail with Occupant Profiles
  Widget _buildRoomDetail() {
    final rooms = selectedRoomType == '2' ? roomsFor2 : roomsFor4;
    final room = rooms.firstWhere((r) => r['roomNumber'] == selectedRoomNumber);
    final occupants = room['occupants'] as List<Map<String, dynamic>>;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C31),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              selectedRoomNumber = null;
            });
          },
        ),
        title: Text(
          room['roomNumber'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Details Card - FIXED: Same size for all rooms
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1B4E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room['roomNumber'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Facilities',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...(room['facilities'] as List<String>).map((facility) => Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Text(
                        '• $facility',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    )).toList(),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Room Occupants Section
              const Text(
                'Room Occupants',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Fixed: Each occupant card has consistent height
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: occupants.length,
                itemBuilder: (context, index) {
                  final occupant = occupants[index];
                  return GestureDetector(
                    onTap: () {
                      _showOccupantProfile(context, occupant);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1B4E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                              image: DecorationImage(
                                image: AssetImage(occupant['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  occupant['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  occupant['major'],
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Color(0xFF8A4FFF),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Select Room Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showBookingConfirmation(context, room['roomNumber']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A4FFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Select This Room',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  void _showOccupantProfile(BuildContext context, Map<String, dynamic> occupant) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFF1D1B4E),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(occupant['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                occupant['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                occupant['major'],
                style: const TextStyle(
                  color: Color(0xFF8A4FFF),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Age: ${occupant['age']}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white24),
              const SizedBox(height: 12),
              Text(
                occupant['bio'],
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    _sendMessageToOccupant(context, occupant);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A4FFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Send Message'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessageToOccupant(BuildContext context, Map<String, dynamic> occupant) {
    final TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: const Color(0xFF1D1B4E),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.message,
                color: Color(0xFF8A4FFF),
                size: 50,
              ),
              const SizedBox(height: 16),
              Text(
                'Send message to ${occupant['name']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: messageController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF0F0C31),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white70,
                        side: const BorderSide(color: Colors.white30),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (messageController.text.isNotEmpty) {
                          final matchedUser = UserProfile(
                            name: occupant['name'],
                            age: occupant['age'],
                            major: occupant['major'],
                            assetPath: occupant['image'],
                          );

                          _chatManager.createMatch(matchedUser);
                          _chatManager.sendMessage(
                            _chatManager.getChatByUserName(occupant['name'])?.id ?? occupant['name'],
                            messageController.text,
                          );

                          Navigator.pop(dialogContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Message sent to ${occupant['name']}!'),
                              backgroundColor: const Color(0xFF8A4FFF),
                            ),
                          );

                          Navigator.pushNamed(context, '/main-nav');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8A4FFF),
                      ),
                      child: const Text('Send'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context, String roomNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1D1B4E),
        title: const Text(
          'Booking Request Sent!',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 50),
            const SizedBox(height: 12),
            Text(
              'You have requested to book $roomNumber',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'The owner will review your request.',
              style: TextStyle(color: Colors.white38),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() {
                selectedRoomNumber = null;
                selectedRoomType = null;
              });
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF8A4FFF))),
          ),
        ],
      ),
    );
  }
}