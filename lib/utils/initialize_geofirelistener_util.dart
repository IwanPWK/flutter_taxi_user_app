import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistants/geofire_assistant.dart';
import '../models/active_nearby_available_drivers.dart';
import 'display_active_drivers_util.dart';

class InitializeGeofireListenerUtil {
  // static BitmapDescriptor? activeNearbyIcon;
  // static void setIcon(BitmapDescriptor? icon) {
  //   activeNearbyIcon = icon;
  // }

  static initializeGeoFireListener(Position? userCurrentPosition, bool activeNearbyDriverKeysLoaded, void Function(void Function()) setState,
      Set<Marker> markersSet, Set<Circle> circlesSet, BitmapDescriptor? activeNearbyIcon) {
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
              DisplayActiveDrivers.displayActiveDriversOnUsersMap(setState, markersSet, circlesSet, activeNearbyIcon);
            }
            break;

          //whenever any driver become non-active/offline
          case Geofire.onKeyExited:
            GeoFireAssistant.deleteOfflineDriverFromList(map['key']);
            DisplayActiveDrivers.displayActiveDriversOnUsersMap(setState, markersSet, circlesSet, activeNearbyIcon);
            break;

          //whenever driver moves - update driver location
          case Geofire.onKeyMoved:
            ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
            activeNearbyAvailableDriver.locationLatitude = map['latitude'];
            activeNearbyAvailableDriver.locationLongitude = map['longitude'];
            activeNearbyAvailableDriver.driverId = map['key'];
            GeoFireAssistant.updateActiveNearbyAvailableDriverLocation(activeNearbyAvailableDriver);
            DisplayActiveDrivers.displayActiveDriversOnUsersMap(setState, markersSet, circlesSet, activeNearbyIcon);
            break;

          //display those online/active drivers on user's map
          case Geofire.onGeoQueryReady:
            activeNearbyDriverKeysLoaded = true;
            DisplayActiveDrivers.displayActiveDriversOnUsersMap(setState, markersSet, circlesSet, activeNearbyIcon);
            break;
        }
      }

      setState(() {});
    });
  }
}
