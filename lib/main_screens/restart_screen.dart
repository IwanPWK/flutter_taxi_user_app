import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/progress_dialog.dart';
import 'main_screen.dart';

class RestartScreen extends StatefulWidget {
  const RestartScreen({super.key});

  @override
  State<RestartScreen> createState() => _RestartScreenState();
}

class _RestartScreenState extends State<RestartScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MainScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Dialog.fullscreen(
        child: ProgressDialog(
          message: 'Please wait',
        ),
      ),
    );
  }
}
