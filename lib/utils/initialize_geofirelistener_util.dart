import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';

import '../assistants/geofire_assistant.dart';
import '../models/active_nearby_available_drivers.dart';
import 'display_active_drivers_util.dart';

class InitializeGeofireListenerUtil {
  static bool activeNearbyDriverKeysLoaded = false;
  // static BitmapDescriptor? activeNearbyIcon;
  // static void setIcon(BitmapDescriptor? icon) {
  //   activeNearbyIcon = icon;
  // }

  static initializeGeoFireListener(BuildContext context, Position? userCurrentPosition) {
    // InitializeGeofireListenerUtil DisplayActiveDriversOnUsersMap = InitializeGeofireListenerUtil();
    Geofire.initialize("activeDrivers");
    Geofire.queryAtLocation(userCurrentPosition!.latitude, userCurrentPosition.longitude, 3)!.listen((map) {
      print('cek map $map');
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered:
            ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
            activeNearbyAvailableDriver.locationLatitude = map['latitude'];
            activeNearbyAvailableDriver.locationLongitude = map['longitude'];
            activeNearbyAvailableDriver.driverId = map['key'];
            GeoFireAssistant.activeNearbyAvailableDriversList.add(activeNearbyAvailableDriver);
            if (activeNearbyDriverKeysLoaded == true) {
              // DisplayActiveDriversOnUsersMap.displayActiveDriversOnUsersMap(setState, markersSet, circlesSet);
              DisplayActiveDrivers.displayActiveDriversOnUsersMap(context);
            }
            break;

          //whenever any driver become non-active/offline
          case Geofire.onKeyExited:
            GeoFireAssistant.deleteOfflineDriverFromList(map['key']);
            DisplayActiveDrivers.displayActiveDriversOnUsersMap(context);
            break;

          //whenever driver moves - update driver location
          case Geofire.onKeyMoved:
            ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
            activeNearbyAvailableDriver.locationLatitude = map['latitude'];
            activeNearbyAvailableDriver.locationLongitude = map['longitude'];
            activeNearbyAvailableDriver.driverId = map['key'];
            GeoFireAssistant.updateActiveNearbyAvailableDriverLocation(activeNearbyAvailableDriver);
            DisplayActiveDrivers.displayActiveDriversOnUsersMap(context);
            break;

          //display those online/active drivers on user's map
          case Geofire.onGeoQueryReady:
            activeNearbyDriverKeysLoaded = true;
            DisplayActiveDrivers.displayActiveDriversOnUsersMap(context);
            break;
        }
      }

      // setState(() {});
    });
  }
}
