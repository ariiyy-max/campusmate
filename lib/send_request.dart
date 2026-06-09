import 'package:flutter/material.dart';

class SendRequestDialog extends StatefulWidget {
  final String userName;
  final String userMajor;

  const SendRequestDialog({
    super.key,
    required this.userName,
    required this.userMajor,
  });

  @override
  State<SendRequestDialog> createState() => _SendRequestDialogState();
}

class _SendRequestDialogState extends State<SendRequestDialog> {
  int dialogState = 0; // 0: Send Interest, 1: Request Sent, 2: It's a Match, 3: Bummer

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFF3EEFF), Color(0xFFE5D9FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // State 0: Send Interest
            if (dialogState == 0) ...[
              const Text(
                "Send Interest",
                style: TextStyle(fontSize: 30, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF8A4FFF),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 15),
              Text(
                widget.userName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Text(
                widget.userMajor,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              Text(
                "Interested to become roommates with ${widget.userName}?",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              _buildPrimaryButton("SEND REQUEST", () => setState(() => dialogState = 1)),
              const SizedBox(height: 10),
              _buildSecondaryButton("CANCEL", () => Navigator.pop(context)),
            ]

            // State 1: Request Sent
            else if (dialogState == 1) ...[
              const Text(
                "Request Sent",
                style: TextStyle(fontSize: 30, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF8A4FFF),
                child: Icon(Icons.check, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 15),
              Text(
                widget.userName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Text(
                widget.userMajor,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              const Text(
                "Your roommate request was sent!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                "Wait for ${widget.userName} to accept your request.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 35),
              _buildPrimaryButton("KEEP SWIPING", () => setState(() => dialogState = 2)),
            ]

            // State 2: It's a Match!
            else if (dialogState == 2) ...[
                const Text(
                  "It's a Match!",
                  style: TextStyle(fontSize: 32, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: -15),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xFF8A4FFF),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "${widget.userName} likes you too!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(height: 35),
                _buildPrimaryButton("SEND A MESSAGE", () => setState(() => dialogState = 3)),
                const SizedBox(height: 10),
                _buildSecondaryButton("KEEP SWIPING", () => Navigator.pop(context)),
              ]

              // State 3: It's a Bummer
              else if (dialogState == 3) ...[
                  const Text(
                    "It's a Bummer",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: -15),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black45,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "It's not a match!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  const SizedBox(height: 35),
                  _buildSecondaryButton("KEEP SWIPING", () => Navigator.pop(context)),
                ]
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD600D6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFD600D6), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Color(0xFFD600D6), fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}