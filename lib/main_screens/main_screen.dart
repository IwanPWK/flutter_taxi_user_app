import 'package:flutter/material.dart';

import '../authentication_screen/login_screen.dart';
import '../global/global.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text("Logout"),
        onPressed: () {
          fAuth.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const LoginScreen()));
        },
      ),
    );
  }
}
