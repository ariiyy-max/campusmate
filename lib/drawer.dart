import 'package:campusmate/homescreen.dart';
import 'package:flutter/material.dart';

import 'loginorsignup/Signupscreen.dart';

void main() {
  runApp(const DrawerScreen());
}

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const _DrawerHeader(),
          Expanded(
            child: _DrawerBody(
              onItemTap: (item) {
                Navigator.pop(context);
                _onMenuItemTapped(context, item);
              },
              onLogout: () {
                Navigator.pop(context);
                _onLogout(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onMenuItemTapped(BuildContext context, String item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $item'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Color(0xFF7C4DFF)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Drawer Header ───────────────────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple background
        Container(
          width: double.infinity,
          height: 166,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/backdrawer.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 30,
          child: Row(
            children: [
              // Avatar
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD4B8E0),
                  border: Border.all(color: Colors.white54, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset("images/profilepersonjpeg-removebg-preview.png", fit: BoxFit.cover),
                  ),
                  // child: Image.asset('assets/avatar_maya.png', fit: BoxFit.cover),
                ),
              const SizedBox(width: 12),
              // Name + ID
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Maya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'D24316883',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Wave at bottom of header
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: _WaveClipper(),
            child: Container(height: 30, color: Colors.white),
          ),
        ),
        // Back arrow
        Positioned(
          top: 16,
          left: 8,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white70, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}

// Wave clipper for the curved bottom edge of the header
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => false;
}

// ─── Drawer Body ─────────────────────────────────────────────────────────────

class _DrawerBody extends StatelessWidget {
  final void Function(String item) onItemTap;
  final VoidCallback onLogout;

  const _DrawerBody({required this.onItemTap, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItem(icon: Icons.person_outline, label: 'Personal information'),
      _MenuItem(icon: Icons.help_outline, label: 'Help center'),
      _MenuItem(icon: Icons.chat_bubble_outline, label: 'F.A.Q'),
      _MenuItem(icon: Icons.settings_outlined, label: 'Settings'),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 20),
      child: Column(
        children: [
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DrawerMenuItem(
                icon: item.icon,
                label: item.label,
                onTap: () => onItemTap(item.label),
              ),
            ),
          ),
          const Spacer(),
          _LogoutButton(onTap: onLogout),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;

  const _MenuItem({required this.icon, required this.label});
}

// ─── Menu Item Tile ───────────────────────────────────────────────────────────

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE8E4F0)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: const Color(0xFF7C4DFF)),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF1A1035),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Logout Button ────────────────────────────────────────────────────────────

class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7C4DFF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Signupscreen()),
          );
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
