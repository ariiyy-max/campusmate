import 'package:flutter/material.dart';
import 'package:campusmate/compatibility_quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Flow',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const NameInputScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------- FIRST SCREEN: FULL NAME ----------------

class NameInputScreen extends StatefulWidget {
  final String? existingName;
  final String? existingNickname;
  final String? existingCourse;
  final String? existingMatrix;

  const NameInputScreen({
    super.key,
    this.existingName,
    this.existingNickname,
    this.existingCourse,
    this.existingMatrix,
  });

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Auto-fill name if already entered before
    if (widget.existingName != null) {
      _nameController.text = widget.existingName!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                SizedBox(
                  width: double.infinity,
                  height: 3.0,
                  child: Stack(
                    children: [
                      Container(width: double.infinity, height: 3.0, color: const Color(0xFFE8E0F5)),
                      Container(width: MediaQuery.of(context).size.width * 0.047, height: 3.0, color: const Color(0xFF5A2E91)),
                    ],
                  ),
                ),
                const SizedBox(height: 80.0),

                // Title
                const Text("What's your full name?", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.3)),
                const SizedBox(height: 32.0),

                // Input
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter Your full name",
                    hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16.0),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5A2E91))),
                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) => value == null || value.trim().isEmpty ? "Please enter your full name" : null,
                ),
                const SizedBox(height: 16.0),
                const Text("This is how it will appear on your profile.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),
                const SizedBox(height: 4.0),
                const Text("This action is permanent.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),

                const Spacer(),

                // Next — PASS ALL DATA FORWARD
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NicknameInputScreen(
                              existingName: _nameController.text,
                              existingNickname: widget.existingNickname,
                              existingCourse: widget.existingCourse,
                              existingMatrix: widget.existingMatrix,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A2E91),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      elevation: 0,
                    ),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Next", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6.0),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- 2. NICKNAME SCREEN (FIXED: keep existing data) ----------------
class NicknameInputScreen extends StatefulWidget {
  final String existingName;
  final String? existingNickname;
  final String? existingCourse;
  final String? existingMatrix;

  const NicknameInputScreen({
    super.key,
    required this.existingName,
    this.existingNickname,
    this.existingCourse,
    this.existingMatrix,
  });

  @override
  State<NicknameInputScreen> createState() => _NicknameInputScreenState();
}

class _NicknameInputScreenState extends State<NicknameInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingNickname != null) {
      _nicknameController.text = widget.existingNickname!;
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 3.0,
                  child: Stack(
                    children: [
                      Container(width: double.infinity, height: 3.0, color: const Color(0xFFE8E0F5)),
                      Container(width: MediaQuery.of(context).size.width * 0.094, height: 3.0, color: const Color(0xFF5A2E91)),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Transform.translate(
                  offset: const Offset(-14, 0),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22.0),
                  ),
                ),
                const SizedBox(height: 12.0),

                const Text("What's your nickname?", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.3)),
                const SizedBox(height: 32.0),

                TextFormField(
                  controller: _nicknameController,
                  decoration: const InputDecoration(
                    hintText: "Enter nickname name",
                    hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16.0),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5A2E91))),
                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) => value == null || value.trim().isEmpty ? "Please enter your nickname" : null,
                ),
                const SizedBox(height: 16.0),
                const Text("This is how it will appear on your profile.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),
                const SizedBox(height: 4.0),
                const Text("This action is permanent.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseInputScreen(
                              existingName: widget.existingName,
                              existingNickname: _nicknameController.text,
                              existingCourse: widget.existingCourse,
                              existingMatrix: widget.existingMatrix,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A2E91),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      elevation: 0,
                    ),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Next", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6.0),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- 3. COURSE SCREEN (FIXED: keep existing data) ----------------
class CourseInputScreen extends StatefulWidget {
  final String existingName;
  final String existingNickname;
  final String? existingCourse;
  final String? existingMatrix;

  const CourseInputScreen({
    super.key,
    required this.existingName,
    required this.existingNickname,
    this.existingCourse,
    this.existingMatrix,
  });

  @override
  State<CourseInputScreen> createState() => _CourseInputScreenState();
}

class _CourseInputScreenState extends State<CourseInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingCourse != null) {
      _courseController.text = widget.existingCourse!;
    }
  }

  @override
  void dispose() {
    _courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 3.0,
                  child: Stack(
                    children: [
                      Container(width: double.infinity, height: 3.0, color: const Color(0xFFE8E0F5)),
                      Container(width: MediaQuery.of(context).size.width * 0.141, height: 3.0, color: const Color(0xFF5A2E91)),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Transform.translate(
                  offset: const Offset(-14, 0),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22.0),
                  ),
                ),
                const SizedBox(height: 12.0),

                const Text("What's your course?", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.3)),
                const SizedBox(height: 32.0),

                TextFormField(
                  controller: _courseController,
                  decoration: const InputDecoration(
                    hintText: "Enter your course",
                    hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16.0),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5A2E91))),
                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) => value == null || value.trim().isEmpty ? "Please enter your course" : null,
                ),
                const SizedBox(height: 16.0),
                const Text("This is how it will appear on your profile.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),
                const SizedBox(height: 4.0),
                const Text("This action is permanent.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatrixNumberInputScreen(
                              existingName: widget.existingName,
                              existingNickname: widget.existingNickname,
                              existingCourse: _courseController.text,
                              existingMatrix: widget.existingMatrix,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A2E91),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      elevation: 0,
                    ),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Next", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6.0),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- 4. MATRIX SCREEN (FIXED: Edit Name button now keeps data) ----------------
class MatrixNumberInputScreen extends StatefulWidget {
  final String existingName;
  final String existingNickname;
  final String existingCourse;
  final String? existingMatrix;

  const MatrixNumberInputScreen({
    super.key,
    required this.existingName,
    required this.existingNickname,
    required this.existingCourse,
    this.existingMatrix,
  });

  @override
  State<MatrixNumberInputScreen> createState() => _MatrixNumberInputScreenState();
}

class _MatrixNumberInputScreenState extends State<MatrixNumberInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _matrixController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingMatrix != null) {
      _matrixController.text = widget.existingMatrix!;
    }
  }

  // ✅ Must have letters AND numbers
  bool _hasLetterAndNumber(String input) {
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(input);
    final hasNumber = RegExp(r'[0-9]').hasMatch(input);
    return hasLetter && hasNumber;
  }

  // ✅ FIXED POPUP: Edit Name now keeps all old data
  void _showWelcomePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("👋", style: TextStyle(fontSize: 32.0)),
                const SizedBox(height: 12.0),
                Text(
                  "Welcome, ${widget.existingNickname}!",
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Let's get your profile set up first.",
                  style: TextStyle(fontSize: 14.0, color: Color(0xFF757575)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),

                // Let's Go Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // close popup
                      // Navigate to birthday screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const BirthdayScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A2E91),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Let's go",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                // ✅ FIXED EDIT NAME BUTTON — GO BACK WITH DATA
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // close popup
                    // Go back to name screen + send all existing data so no retype
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NameInputScreen(
                          existingName: widget.existingName,
                          existingNickname: widget.existingNickname,
                          existingCourse: widget.existingCourse,
                          existingMatrix: _matrixController.text,
                        ),
                      ),
                          (route) => false,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Text(
                    "Edit name",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF757575),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _matrixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 3.0,
                  child: Stack(
                    children: [
                      Container(width: double.infinity, height: 3.0, color: const Color(0xFFE8E0F5)),
                      Container(width: MediaQuery.of(context).size.width * 0.188, height: 3.0, color: const Color(0xFF5A2E91)),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Transform.translate(
                  offset: const Offset(-14, 0),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22.0),
                  ),
                ),
                const SizedBox(height: 12.0),

                const Text("What's your Matrix Number?", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.3)),
                const SizedBox(height: 32.0),

                TextFormField(
                  controller: _matrixController,
                  decoration: const InputDecoration(
                    hintText: "Enter Your matrix no.",
                    hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16.0),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5A2E91))),
                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Please enter your matrix number";
                    if (!_hasLetterAndNumber(value.trim())) return "Must contain both letters and numbers";
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text("This is how it will appear on your profile.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),
                const SizedBox(height: 4.0),
                const Text("This action is permanent.", style: TextStyle(fontSize: 14.0, color: Color(0xFF757575))),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showWelcomePopup();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A2E91),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      elevation: 0,
                    ),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Next", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white)),
                      SizedBox(width: 6.0),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}