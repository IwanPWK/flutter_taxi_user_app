import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistants/geofire_assistant.dart';
import '../models/active_nearby_available_drivers.dart';

class DisplayActiveDrivers {
  static displayActiveDriversOnUsersMap(
      void Function(void Function()) setState, Set<Marker> markersSet, Set<Circle> circlesSet, BitmapDescriptor? activeNearbyIcon) {
    setState(() {
      markersSet.clear();
      circlesSet.clear();

      Set<Marker> driversMarkerSet = <Marker>{};

      for (ActiveNearbyAvailableDrivers eachDriver in GeoFireAssistant.activeNearbyAvailableDriversList) {
        LatLng eachDriverActivePosition = LatLng(eachDriver.locationLatitude!, eachDriver.locationLongitude!);

        Marker marker = Marker(
          markerId: MarkerId("driver${eachDriver.driverId!}"),
          position: eachDriverActivePosition,
          icon: activeNearbyIcon!,
          rotation: 360,
        );

        driversMarkerSet.add(marker);
      }

      setState(() {
        markersSet = driversMarkerSet;
      });
    });
  }
}
