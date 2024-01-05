import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../app_handler/map_handler.dart';
import '../assistants/geofire_assistant.dart';
import '../globals/global.dart';
import '../models/active_nearby_available_drivers.dart';

class DisplayActiveDrivers {
  static displayActiveDriversOnUsersMap(BuildContext context) {
    // setState(() {
    Provider.of<MapHandler>(context, listen: false).clearMarkersSet();
    Provider.of<MapHandler>(context, listen: false).clearCirclesSet();
    // markersSet.clear();
    // circlesSet.clear();

    // Set<Marker> driversMarkerSet = <Marker>{};

    for (ActiveNearbyAvailableDrivers eachDriver in GeoFireAssistant.activeNearbyAvailableDriversList) {
      LatLng eachDriverActivePosition = LatLng(eachDriver.locationLatitude!, eachDriver.locationLongitude!);

      Marker marker = Marker(
        markerId: MarkerId("driver${eachDriver.driverId!}"),
        position: eachDriverActivePosition,
        icon: activeNearbyIcon!,
        rotation: 360,
      );

      Provider.of<MapHandler>(context, listen: false).updateMarkersSet(marker);
      // driversMarkerSet.add(marker);
    }

    // setState(() {

    // markersSet = driversMarkerSet;
    // });
    // });
  }
}
