// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_handler/map_handler.dart';
import '../../utils/locate_position_util.dart';
import '../../utils/themes_map_util.dart';

class GoogleMapWidget extends StatefulWidget {
  // Set<Polyline> polyLineSet;
  // Set<Marker> markersSet;
  // Set<Circle> circlesSet;
  // String userName;
  // String userEmail;
  // BitmapDescriptor? activeNearbyIcon;
  // void Function({
  //   required GoogleMapController updGoogleMapController,
  // }) updateGoogleMapController;

  GoogleMapWidget({
    Key? key,
    // required this.polyLineSet,
    // required this.markersSet,
    // required this.circlesSet,
    // required this.userName,
    // required this.userEmail,
    // this.activeNearbyIcon,
    // required this.updateGoogleMapController,
  }) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  double bottomPaddingOfMap = 0;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Position? userCurrentPosition;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late MapHandler appController;
  // @override
  // void didChangeDependencies() {

  //   super.didChangeDependencies();
  // }

  // bool activeNearbyDriverKeysLoaded = false;

  @override
  Widget build(BuildContext context) {
    appController = Provider.of<MapHandler>(context, listen: false);
    print('tes10 ${Provider.of<MapHandler>(context).markersSet}');
    return GoogleMap(
      padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: _kGooglePlex,
      polylines: Provider.of<MapHandler>(context).polyLineSet,
      markers: Provider.of<MapHandler>(context).markersSet,
      circles: Provider.of<MapHandler>(context).circlesSet,
      onMapCreated: (GoogleMapController controller) {
        _controllerGoogleMap.complete(controller);
        appController.setGoogleMapController(controller);
        // newGoogleMapController = controller;
        print('tes11');
        //for black theme google map
        ThemesMapUtil.blackThemeGoogleMap(appController.newGoogleMapController);

        setState(() {
          bottomPaddingOfMap = 240;
        });

        // widget.updateGoogleMapController(updGoogleMapController: newGoogleMapController!);
        print('locateUserTop');
        LocatePosition.locateUserPosition(context);
        print('locateUser');
      },
    );
  }
}
