import 'package:flutter/material.dart';

class SendRequestDialog extends StatefulWidget {
  final String userName;
  final String userMajor;
  final VoidCallback onRequestSent;
  final VoidCallback onMatch;
  final VoidCallback onDialogClose;

  const SendRequestDialog({
    super.key,
    required this.userName,
    required this.userMajor,
    required this.onRequestSent,
    required this.onMatch,
    required this.onDialogClose,
  });

  @override
  State<SendRequestDialog> createState() => _SendRequestDialogState();
}

class _SendRequestDialogState extends State<SendRequestDialog> {
  int dialogState = 0; // 0: send interest, 1: request sent, 2: match, 3: bummer

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dialogState == 0) ...[
              const Text(
                "Send Interest",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF8A4FFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF8A4FFF),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.userMajor,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                "Interested to become roommates with ${widget.userName}?",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              _buildPrimaryButton("SEND REQUEST", () {
                setState(() => dialogState = 1);
                widget.onRequestSent();
              }),
              const SizedBox(height: 10),
              _buildSecondaryButton("CANCEL", () {
                widget.onDialogClose();
                Navigator.pop(context);
              }),
            ] else if (dialogState == 1) ...[
              const Text(
                "Request Sent",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF8A4FFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 50,
                  color: Color(0xFF8A4FFF),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.userMajor,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your roommate request was sent!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Wait for ${widget.userName} to accept your request.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 25),
              _buildPrimaryButton("KEEP SWIPING", () {
                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF8A4FFF)),
                    ),
                  ),
                );

                // Simulate waiting for response (2 seconds)
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context); // Close loading dialog

                  // Randomly decide match or bummer (50% chance)
                  final bool isMatch = DateTime.now().millisecondsSinceEpoch % 2 == 0;

                  setState(() {
                    dialogState = isMatch ? 2 : 3;
                  });

                  if (isMatch) {
                    widget.onMatch();
                  }
                });
              }),
            ] else if (dialogState == 2) ...[
              const Text(
                "It's a Match!",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF8A4FFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 35, color: Colors.grey),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0E6FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFF8A4FFF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "${widget.userName} likes you too!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              _buildPrimaryButton("SEND A MESSAGE", () {
                widget.onMatch();
                Navigator.pop(context);
              }),
              const SizedBox(height: 10),
              _buildSecondaryButton("KEEP SWIPING", () {
                widget.onDialogClose();
                Navigator.pop(context);
              }),
            ] else if (dialogState == 3) ...[
              const Text(
                "It's a Bummer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF8A4FFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 35, color: Colors.grey),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD0D0D0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 35, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "It's not a match!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              _buildSecondaryButton("KEEP SWIPING", () {
                widget.onDialogClose();
                Navigator.pop(context);
              }),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8A4FFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF8A4FFF), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF8A4FFF),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}