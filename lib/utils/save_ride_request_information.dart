import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../app_handler/map_handler.dart';
import '../assistants/geofire_assistant.dart';
import '../globals/global.dart';
import '../splash_screen/restart_screen.dart';
import '../models/active_nearby_available_drivers.dart';

// class SaveRideRequestInformation extends StatefulWidget {
//   static List<ActiveNearbyAvailableDrivers> onlineNearbyAvailableDriversList = [];
//   const SaveRideRequestInformation({super.key});

//   @override
//   State<SaveRideRequestInformation> createState() => _SaveRideRequestInformationState();
// }

// class _SaveRideRequestInformationState extends State<SaveRideRequestInformation> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class SaveRideRequestInformation {
  static List<ActiveNearbyAvailableDrivers> onlineNearbyAvailableDriversList = [];
  static saveRideRequestInformationMethod(BuildContext context) {
    // 1. save the RideRequest Information
    onlineNearbyAvailableDriversList = GeoFireAssistant.activeNearbyAvailableDriversList;
    searchNearestOnlineDrivers(context);
  }

  static searchNearestOnlineDrivers(BuildContext context) async {
    if (onlineNearbyAvailableDriversList.isEmpty) {
      // cancel or delete the RideRequest Information

      Fluttertoast.showToast(msg: "No Online Nearest Driver Available. Please try again later.");
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const RestartScreen()));
      });
      return;
    }
    await retrieveOnlineDriversInformation(onlineNearbyAvailableDriversList);
  }

  static retrieveOnlineDriversInformation(List onlineNearestDriversList) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("drivers");
    for (int i = 0; i < onlineNearestDriversList.length; i++) {
      await ref.child(onlineNearestDriversList[i].driverId.toString()).once().then((dataSnapshot) {
        var driverKeyInfo = dataSnapshot.snapshot.value;
        dList.add(driverKeyInfo);
        print('Driver\'s Information ${dList.toList()}');
      });
    }
  }
}
