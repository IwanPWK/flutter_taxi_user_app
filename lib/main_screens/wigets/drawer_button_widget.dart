// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_handler/app_info.dart';
import '../../app_handler/map_handler.dart';
import '../../models/directions.dart';

class DrawerButtonWidget extends StatelessWidget {
  // Set<Polyline> polyLineSet;
  // Set<Marker> markersSet;
  // Set<Circle> circlesSet;
  GlobalKey<ScaffoldState> sKey;

  DrawerButtonWidget({
    Key? key,
    // required this.polyLineSet,
    // required this.markersSet,
    // required this.circlesSet,
    required this.sKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Directions? userDropOffLocation = Provider.of<AppInfo>(context).userDropOffLocation;
    return Positioned(
      top: 30,
      left: 14,
      child: GestureDetector(
        onTap: () async {
          if (userDropOffLocation == null) {
            sKey.currentState!.openDrawer();
          } else {
            Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            if (context.mounted) {
              MapHandler mapHandler = Provider.of<MapHandler>(context, listen: false);
              mapHandler.updateUserCurrentPosition(cPosition);

              LatLng latLngPosition = LatLng(mapHandler.userCurrentPosition!.latitude, mapHandler.userCurrentPosition!.longitude);

              CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

              Provider.of<MapHandler>(context, listen: false).cameraUpdateMethod(CameraUpdate.newCameraPosition(cameraPosition));

              Provider.of<AppInfo>(context, listen: false).clearDropOffLocation();
              Provider.of<MapHandler>(context, listen: false).clearMarkersSet();
              Provider.of<MapHandler>(context, listen: false).clearPolyLineSet();
              Provider.of<MapHandler>(context, listen: false).clearCirclesSet();
            }
          }
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            (userDropOffLocation == null) ? Icons.menu : Icons.close,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
