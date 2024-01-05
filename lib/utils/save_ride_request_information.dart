import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../app_handler/app_info.dart';
import '../assistants/geofire_assistant.dart';
import '../globals/global.dart';
import '../main_screens/select_nearest_active_driver_screen.dart';
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
  DatabaseReference? rideRequestRef = FirebaseDatabase.instance.ref().child("All Ride Requests");
  static List<ActiveNearbyAvailableDrivers> onlineNearbyAvailableDriversList = [];
  static saveRideRequestInformationMethod(BuildContext context) {
    var originLocation = Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
    var destinationLocation = Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

    Map originLocationMap = {
      "latitude": originLocation!.locationLatitude.toString(),
      "longitude": originLocation.locationLatitude.toString(),
    };

    Map destinationLocationMap = {
      "latitude": destinationLocation!.locationLatitude.toString(),
      "longitude": destinationLocation.locationLatitude.toString(),
    };

    Map userInformationMap = {
      "origin": originLocationMap,
      "destination": destinationLocationMap,
      "time": DateTime.now().toString(),
      "userName": userModelCurrentInfo!.name,
    };

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
    // active driver available
    await retrieveOnlineDriversInformation(onlineNearbyAvailableDriversList);
    if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (c) => const SelectNearestActiveDriversScreen()));
  }

  static retrieveOnlineDriversInformation(List onlineNearestDriversList) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("drivers");
    for (int i = 0; i < onlineNearestDriversList.length; i++) {
      await ref.child(onlineNearestDriversList[i].driverId.toString()).once().then((dataSnapshot) {
        var driverKeyInfo = dataSnapshot.snapshot.value;
        dList.add(driverKeyInfo);
      });
    }
  }
}
