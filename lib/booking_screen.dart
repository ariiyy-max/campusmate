import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Select Your Room',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Room List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Room 1
                  _buildRoomCard(
                    context,
                    roomNumber: "AGO-01",
                    roomType: "Room for 2",
                    price: "RM 450",
                    facilities: ["2 double decker", "4 locker", "4 table"],
                    occupants: ["Sophia", "Emma"],
                    imagePath: "assets/room1.png",
                    isFavorite: true,
                  ),
                  const SizedBox(height: 16),

                  // Room 2
                  _buildRoomCard(
                    context,
                    roomNumber: "AGO-05",
                    roomType: "Room for 4",
                    price: "RM 350",
                    facilities: ["2 double decker", "4 locker", "4 table"],
                    occupants: ["Mia", "Lisa", "Anna", "Sara"],
                    imagePath: "assets/room2.png",
                    isFavorite: false,
                  ),
                  const SizedBox(height: 16),

                  // Room 3
                  _buildRoomCard(
                    context,
                    roomNumber: "AGO-08",
                    roomType: "Room for 2",
                    price: "RM 500",
                    facilities: ["2 double decker", "4 locker", "4 table", "AC"],
                    occupants: ["Zoe", "Maya"],
                    imagePath: "assets/room3.png",
                    isFavorite: false,
                  ),
                  const SizedBox(height: 16),

                  // Room 4
                  _buildRoomCard(
                    context,
                    roomNumber: "AGO-12",
                    roomType: "Room for 6",
                    price: "RM 300",
                    facilities: ["3 double decker", "6 locker", "6 table"],
                    occupants: ["Sarah", "John", "Mike", "Lisa", "Tom", "Amy"],
                    imagePath: "assets/room4.png",
                    isFavorite: true,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(
      BuildContext context, {
        required String roomNumber,
        required String roomType,
        required String price,
        required List<String> facilities,
        required List<String> occupants,
        required String imagePath,
        required bool isFavorite,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161439),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Image with Favorite Icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: const Color(0xFF2D1B4E),
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.white38),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    // Toggle favorite
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isFavorite ? 'Removed from favorites' : 'Added to favorites'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: const Color(0xFF8A4FFF),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A4FFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "From $price/month",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Room Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      roomNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      roomType,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Facilities
                const Text(
                  "Facilities",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: facilities.map((facility) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D1B4E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        facility,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                // Room Occupants
                const Text(
                  "Room Occupants",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: occupants.map((occupant) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8A4FFF).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF8A4FFF).withOpacity(0.5)),
                      ),
                      child: Text(
                        occupant,
                        style: const TextStyle(
                          color: Color(0xFF8A4FFF),
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // Select Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showRoomDetailDialog(context, roomNumber, roomType, price, facilities, occupants);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A4FFF),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Select Room",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRoomDetailDialog(
      BuildContext context,
      String roomNumber,
      String roomType,
      String price,
      List<String> facilities,
      List<String> occupants,
      ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFF1D1B4E),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.home_work, size: 50, color: Color(0xFF8A4FFF)),
              const SizedBox(height: 16),
              Text(
                roomNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                roomType,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF8A4FFF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "From $price/month",
                  style: const TextStyle(
                    color: Color(0xFF8A4FFF),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Divider(color: Colors.white24),

              const SizedBox(height: 12),
              const Text(
                "Facilities",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: facilities.map((facility) {
                  return Chip(
                    label: Text(facility, style: const TextStyle(color: Colors.white70)),
                    backgroundColor: const Color(0xFF2D1B4E),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),
              const Text(
                "Room Occupants",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: occupants.map((occupant) {
                  return Chip(
                    label: Text(occupant, style: const TextStyle(color: Color(0xFF8A4FFF))),
                    backgroundColor: const Color(0xFF8A4FFF).withOpacity(0.2),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Close the detail dialog first
                    Navigator.pop(dialogContext);
                    // Then show confirmation
                    _showBookingConfirmation(context, roomNumber);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A4FFF),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Confirm Booking",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white54),
                ),
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
      builder: (BuildContext confirmContext) => AlertDialog(
        backgroundColor: const Color(0xFF1D1B4E),
        title: const Text(
          'Booking Confirmed!',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 50),
            const SizedBox(height: 12),
            Text(
              'You have successfully booked $roomNumber',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'The landlord will contact you soon.',
              style: TextStyle(color: Colors.white38),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // ONLY pop the confirmation dialog, nothing else
              Navigator.pop(confirmContext);
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF8A4FFF))),
          ),
        ],
      ),
    );
  }
}