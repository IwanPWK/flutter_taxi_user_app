import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconMarkerUtil {
  static createActiveNearByDriverIconMarker(BitmapDescriptor? activeNearbyIcon, BuildContext context) {
    if (activeNearbyIcon == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car.png").then((value) {
        activeNearbyIcon = value;
      });
    }
  }
}
