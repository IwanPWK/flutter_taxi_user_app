// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class CheckNetworkUtil extends StatefulWidget {
  const CheckNetworkUtil({super.key});

  @override
  State<CheckNetworkUtil> createState() => _CheckNetworkUtilState();
}

class _CheckNetworkUtilState extends State<CheckNetworkUtil> {
  late StreamSubscription listener;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  var connection = InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 3),
  );

  Future<void> checkIfNetworkIsAvailable() async {
    listener = connection.onStatusChange.listen((InternetStatus status) {
      if (status == InternetStatus.disconnected && isAlertSet == false) {
        showDialogBox();
        setState(() => isAlertSet = true);
      }
    });
  }

  initState() {
    checkIfNetworkIsAvailable();
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
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
                // setState(() => isAlertSet = false);
                print('cek 3 $isAlertSet');
                isAlertSet = false;
                setState;

                isDeviceConnected = await connection.hasInternetAccess;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  // setState(() => isAlertSet = true);
                  isAlertSet = true;
                  setState;
                  print('cek 4 $isAlertSet');
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
