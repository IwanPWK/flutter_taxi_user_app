import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHandler extends ChangeNotifier {
  Set<Polyline> polyLineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  GoogleMapController? newGoogleMapController;
  Position? userCurrentPosition;
  bool activeNearbyDriverKeysLoaded = false;
  BitmapDescriptor? activeNearbyIcon;

  void updatePolyLineSet(Polyline polyline) {
    polyLineSet.add(polyline);
    notifyListeners();
  }

  void updateMarkersSet(Marker markers) {
    markersSet.add(markers);
    notifyListeners();
  }

  void updateCirclesSet(Circle circles) {
    circlesSet.add(circles);
    notifyListeners();
  }

  void clearPolyLineSet() {
    polyLineSet.clear;
    notifyListeners();
  }

  void clearMarkersSet() {
    markersSet.clear;
    notifyListeners();
  }

  void clearCirclesSet() {
    circlesSet.clear;
    notifyListeners();
  }

  void setGoogleMapController(GoogleMapController controller) {
    newGoogleMapController = controller;
    notifyListeners();
  }

  void cameraUpdateMethod(CameraUpdate cameraUpdate) {
    newGoogleMapController!.animateCamera(cameraUpdate);
    notifyListeners();
  }

  void updateUserCurrentPosition(Position position) {
    userCurrentPosition = position;
    notifyListeners();
  }

  void createActiveNearByDriverIconMarker(BuildContext context) {
    if (activeNearbyIcon == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car.png").then((value) {
        activeNearbyIcon = value;
      });
    }
    notifyListeners();
  }

  void updateActiveNearbyDriverKeysLoaded(bool value) {
    activeNearbyDriverKeysLoaded = value;
    notifyListeners();
  }
}
