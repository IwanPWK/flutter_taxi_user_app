import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assistants/geofire_assistant.dart';
import '../main_screens/restart_screen.dart';
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
  static Function()? clearSets;
  static saveRideRequestInformation(BuildContext context) {
    // 1. save the RideRequest Information
    onlineNearbyAvailableDriversList = GeoFireAssistant.activeNearbyAvailableDriversList;
    searchNearestOnlineDrivers(context);
  }

  static searchNearestOnlineDrivers(BuildContext context) {
    if (onlineNearbyAvailableDriversList.isEmpty) {
      // cancel or delete the RideRequest Information
      clearSets!();
      Fluttertoast.showToast(msg: "No Online Nearest Driver Available. Please try again later.");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const RestartScreen()));
      return;
    }
  }
}
