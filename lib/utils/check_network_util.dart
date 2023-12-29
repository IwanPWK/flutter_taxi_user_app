import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class CheckNetworkutil {
  static Future<void> checkIfNetworkIsAvailable(
    BuildContext context,
    StreamSubscription? listener,
    bool isAlertSet,
    bool isDeviceConnected,
    Function(BuildContext context, bool isAlertSet, bool isDeviceConnected) showDialogBox,
    // void Function(void Function()) setState
  ) async {
    listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
      print('cek 1 $isAlertSet');
      if (status == InternetStatus.disconnected && isAlertSet == false) {
        showDialogBox(context, isAlertSet, isDeviceConnected);
        // setState(() => isAlertSet = true);
        isAlertSet = true;
        print('cek 2 $isAlertSet');
      }
    });
  }
}
