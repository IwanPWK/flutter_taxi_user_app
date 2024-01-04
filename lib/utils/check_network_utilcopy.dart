// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// import 'show_dialogbox_util.dart';

// class CheckNetworkutil {
//   static Future<void> checkIfNetworkIsAvailable(
//     BuildContext context,
//     StreamSubscription? listener,
//     bool isAlertSet,
//     bool isDeviceConnected,
//     // Function setState,
//     // Function(BuildContext context, bool isAlertSet, bool isDeviceConnected) showDialogBox,
//     // void Function(void Function()) setState
//   ) async {
//     listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
//       print('cek 1 $isAlertSet');
//       if (status == InternetStatus.disconnected && isAlertSet == false) {
//         ShowDialogboxUtil(
//           isAlertSet: isAlertSet,
//           isDeviceConnected: isDeviceConnected,
//         );
//         // setState(() => isAlertSet = true);
//         isAlertSet = true;
//         // setState;
//         print('cek 2 $isAlertSet');
//       }
//     });
//   }
// }
