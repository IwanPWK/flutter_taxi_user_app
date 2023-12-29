import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ShowDialogboxUtil {
  static showDialogBox(BuildContext context, bool isAlertSet, bool isDeviceConnected) => showCupertinoDialog<String>(
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

                isDeviceConnected = await InternetConnection().hasInternetAccess;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox(context, isAlertSet, isDeviceConnected);
                  // setState(() => isAlertSet = true);
                  isAlertSet = true;
                  print('cek 4 $isAlertSet');
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
