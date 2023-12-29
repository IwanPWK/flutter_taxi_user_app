import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../assistants/assistant_methods.dart';
import '../authentication_screen/login_screen.dart';
import '../globals/global.dart';
import '../main_screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  startTimer() {
    fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;
    Timer(const Duration(seconds: 3), () async {
      if (fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MainScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
      }
    });
  }

  Future<void> checkIfNetworkIsAvailable() async {
    isDeviceConnected = await InternetConnection().hasInternetAccess;
    if (!isDeviceConnected) {
      fAuth.signOut();
      showDialogBox();
      setState(() => isAlertSet = true);
    } else {
      startTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfNetworkIsAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Uber & inDriver Clone App",
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected = await InternetConnection().hasInternetAccess;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
                checkIfNetworkIsAvailable();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
