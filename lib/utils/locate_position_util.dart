import 'package:flutter/material.dart';
import 'package:flutter_taxi_user_app/utils/initialize_geofirelistener_util.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistants/assistant_methods.dart';
import '../globals/global.dart';

class LocatePosition {
  static locateUserPosition(
      BuildContext context,
      GoogleMapController? newGoogleMapController,
      Position? userCurrentPosition,
      String userName,
      String userEmail,
      bool activeNearbyDriverKeysLoaded,
      void Function(void Function()) setState,
      Set<Marker> markersSet,
      Set<Circle> circlesSet,
      BitmapDescriptor? activeNearbyIcon) async {
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress = await AssistantMethods.searchAddressFromGeographicCoOrdinates(userCurrentPosition, context);
    print("this is your address = " + humanReadableAddress);

    userName = userModelCurrentInfo!.name!;
    userEmail = userModelCurrentInfo!.email!;

    InitializeGeofireListenerUtil.initializeGeoFireListener(
        userCurrentPosition, activeNearbyDriverKeysLoaded, setState, markersSet, circlesSet, activeNearbyIcon);
  }
}
