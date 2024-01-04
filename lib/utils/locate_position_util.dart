// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_taxi_user_app/utils/initialize_geofirelistener_util.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// import '../app_handler/app_controller.dart';
import '../app_handler/map_handler.dart';
import '../assistants/assistant_methods.dart';
// import '../globals/global.dart';

// class LocatePosition extends StatefulWidget {
//   const LocatePosition({super.key});

//   @override
//   State<LocatePosition> createState() => _LocatePositionState();
// }

// class _LocatePositionState extends State<LocatePosition> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class LocatePosition {
  static locateUserPosition(
    BuildContext context,
    // GoogleMapController? newGoogleMapController,
    // Position? userCurrentPosition,
    // String userName,
    // String userEmail,
    // bool activeNearbyDriverKeysLoaded,
    // void Function(void Function()) setState,
    // Set<Marker> markersSet,
    // Set<Circle> circlesSet,
    // BitmapDescriptor? activeNearbyIcon
  ) async {
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (!context.mounted) return;
    MapHandler mapHandler = Provider.of<MapHandler>(context, listen: false);
    mapHandler.updateUserCurrentPosition(cPosition);
    print('cPosition');

    LatLng latLngPosition = LatLng(mapHandler.userCurrentPosition!.latitude, mapHandler.userCurrentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

    if (context.mounted) Provider.of<MapHandler>(context, listen: false).cameraUpdateMethod(CameraUpdate.newCameraPosition(cameraPosition));

    // newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    if (!context.mounted) return;
    String humanReadableAddress = await AssistantMethods.searchAddressFromGeographicCoOrdinates(mapHandler.userCurrentPosition!, context);
    print("this is your address = " + humanReadableAddress);

    // userName = userModelCurrentInfo!.name!;
    // userEmail = userModelCurrentInfo!.email!;

    if (context.mounted) InitializeGeofireListenerUtil.initializeGeoFireListener(context, mapHandler.userCurrentPosition);
  }
}
