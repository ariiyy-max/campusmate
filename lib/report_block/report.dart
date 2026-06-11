import 'package:flutter/material.dart';

// REPORT ACCOUNT
class ReportAccountScreen extends StatefulWidget {
  const ReportAccountScreen({super.key});
  @override
  State<ReportAccountScreen> createState() => _ReportAccountScreenState();
}
class _ReportAccountScreenState extends State<ReportAccountScreen> {
  final TextEditingController _reasonController = TextEditingController();
  String? _errorText;
  @override void dispose() { _reasonController.dispose(); super.dispose(); }
  void _submit() {
    final txt = _reasonController.text.trim();
    if (txt.isEmpty) { setState(() => _errorText = "Please enter your reason"); return; }
    setState(() => _errorText = null);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Report submitted")));
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportSuccessScreen()));
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/wave_bg.png'), fit: BoxFit.cover)),
        child: Column(children: [
          Container(color: const Color(0x006A359C), padding: const EdgeInsets.symmetric(horizontal:16, vertical:20), child: SafeArea(child: Row(children: [
            IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back, color:Colors.white)),
            const Expanded(child: Text("Report account", textAlign:TextAlign.center, style: TextStyle(color:Colors.white, fontSize:17, fontWeight:FontWeight.w600))),
            const SizedBox(width:40)
          ]))),
          const SizedBox(height:40),
          const Text("Give a reason", style: TextStyle(fontSize:20, fontWeight:FontWeight.w600)),
          const SizedBox(height:20),
          Padding(padding: const EdgeInsets.symmetric(horizontal:24), child: TextField(controller:_reasonController, decoration: InputDecoration(hintText:"Enter your reason", errorText:_errorText, border:const UnderlineInputBorder(), enabledBorder:const UnderlineInputBorder(borderSide:BorderSide(color:Colors.grey)), focusedBorder:const UnderlineInputBorder(borderSide:BorderSide(color:Color(0xFF6A359C))), errorBorder:const UnderlineInputBorder(borderSide:BorderSide(color:Colors.redAccent))), onChanged:(_)=>setState(()=>_errorText=null))),
          const Spacer(),
          Padding(padding: const EdgeInsets.symmetric(horizontal:24, vertical:30), child: SizedBox(width:double.infinity, height:48, child:ElevatedButton(onPressed:_submit, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF6A359C), shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))), child:const Text("Submit", style:TextStyle(fontSize:16, color: Colors.white)))))
        ]),
      ),
    );
  }
}

// REPORT CONTENT
class ReportContentScreen extends StatefulWidget {
  const ReportContentScreen({super.key});
  @override
  State<ReportContentScreen> createState() => _ReportContentScreenState();
}
class _ReportContentScreenState extends State<ReportContentScreen> {
  final TextEditingController _reasonController = TextEditingController();
  String? _errorText;
  @override void dispose() { _reasonController.dispose(); super.dispose(); }
  void _submit() {
    final txt = _reasonController.text.trim();
    if (txt.isEmpty) { setState(() => _errorText = "Please enter your reason"); return; }
    setState(() => _errorText = null);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Report submitted")));
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportSuccessScreen()));
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/wave_bg.png'), fit: BoxFit.cover)),
        child: Column(children: [
          Container(color: const Color(0x006A359C), padding: const EdgeInsets.symmetric(horizontal:16, vertical:20), child: SafeArea(child: Row(children: [
            IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back, color:Colors.white)),
            const Expanded(child: Text("Report content", textAlign:TextAlign.center, style: TextStyle(color:Colors.white, fontSize:17, fontWeight:FontWeight.w600))),
            const SizedBox(width:40)
          ]))),
          const SizedBox(height:40),
          const Text("Give a reason", style: TextStyle(fontSize:20, fontWeight:FontWeight.w600)),
          const SizedBox(height:20),
          Padding(padding: const EdgeInsets.symmetric(horizontal:24), child: TextField(controller:_reasonController, decoration: InputDecoration(hintText:"Enter your reason", errorText:_errorText, border:const UnderlineInputBorder(), enabledBorder:const UnderlineInputBorder(borderSide:BorderSide(color:Colors.grey)), focusedBorder:const UnderlineInputBorder(borderSide:BorderSide(color:Color(0xFF6A359C))), errorBorder:const UnderlineInputBorder(borderSide:BorderSide(color:Colors.redAccent))), onChanged:(_)=>setState(()=>_errorText=null))),
          const Spacer(),
          Padding(padding: const EdgeInsets.symmetric(horizontal:24, vertical:30), child: SizedBox(width:double.infinity, height:48, child:ElevatedButton(onPressed:_submit, style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF6A359C), shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))), child:const Text("Submit", style:TextStyle(fontSize:16, color: Colors.white)))))
        ]),
      ),
    );
  }
}

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/wave_bg.png'), fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            Container(
              color: const Color(0x006A359C),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22)),
                    const Expanded(child: Text("Report content", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600))),
                    const SizedBox(width: 40)
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Green Check Icon
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF4CD964),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 60),
            ),

            const SizedBox(height: 24),

            const Text(
              "Thanks for reporting",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
            ),

            const SizedBox(height: 12),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "We'll review your report and take action if there is a violation of our community guidelines",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A359C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text("Done", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}