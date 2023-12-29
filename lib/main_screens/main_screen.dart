import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../globals/global.dart';
import '../info_handler/app_info.dart';
import '../utils/check_network_util.dart';
import '../utils/icon_marker_util.dart';
import '../utils/locate_position_util.dart';
import '../utils/show_dialogbox_util.dart';
import '../utils/themes_map_util.dart';
import '../widgets/drawer.dart';
import 'wigets/drawer_button_widget.dart';
import 'wigets/google_map_widget.dart';
import 'wigets/ride_box_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Position? userCurrentPosition;
  bool activeNearbyDriverKeysLoaded = false;
  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  StreamSubscription? listener;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

  var geoLocator = Geolocator();

  // LocationPermission? _locationPermission; //asked permission

  Set<Polyline> polyLineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  String userName = "your Name";
  String userEmail = "your Email";

  bool openNavigationDrawer = true;
  BitmapDescriptor? activeNearbyIcon;
  double bottomPaddingOfMap = 0;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //asked permission
  // checkIfLocationPermissionAllowed() async {
  //   _locationPermission = await Geolocator.requestPermission();

  //   if (_locationPermission == LocationPermission.denied) {
  //     _locationPermission = await Geolocator.requestPermission();
  //   }
  // }

  void updateGoogleMapController({required GoogleMapController updGoogleMapController}) {
    setState(() {
      newGoogleMapController = updGoogleMapController;
    });
  }

  void updateSets({
    required Set<Polyline> polyLines,
    required Set<Marker> markers,
    required Set<Circle> circles,
  }) {
    setState(() {
      polyLineSet = polyLines;
      markersSet = markers;
      circlesSet = circles;
    });
  }

  @override
  void initState() {
    CheckNetworkutil.checkIfNetworkIsAvailable(
      context,
      listener,
      isAlertSet,
      isDeviceConnected,
      ShowDialogboxUtil.showDialogBox,
      // setState,
    );

    super.initState();
  }

  @override
  dispose() {
    listener!.cancel();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //asked permission
  // checkIfLocationPermissionAllowed(); kesalahan dikarenakan memanggil checkIfLocationPermissionAllowed di file main_screen.dart
  //karena sebagai permission telat untuk meminta permission, karena map sudah terlanjut di load
  // }

  @override
  Widget build(BuildContext context) {
    IconMarkerUtil.createActiveNearByDriverIconMarker(activeNearbyIcon, context);
    return WillPopScope(
      onWillPop: () async {
        if (!openNavigationDrawer) {
          openNavigationDrawer = true;
          Provider.of<AppInfo>(context, listen: false).clearDropOffLocation();
          setState(() {
            markersSet.clear();
            circlesSet.clear();
            polyLineSet.clear();
          });

          return false;
        } else {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to exit and logout?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      fAuth.signOut();
                      Navigator.pop(context, true);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        }
      },
      child: Scaffold(
        key: sKey,
        drawer: SizedBox(
          width: 265,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
            ),
            child: DrawerWidget(
              name: userName,
              email: userEmail,
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMapWidget(
                  circlesSet: circlesSet,
                  polyLineSet: polyLineSet,
                  markersSet: markersSet,
                  userName: userName,
                  userEmail: userEmail,
                  updateGoogleMapController: updateGoogleMapController),
              // GoogleMap(
              //   padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              //   mapType: MapType.normal,
              //   myLocationEnabled: true,
              //   zoomGesturesEnabled: true,
              //   zoomControlsEnabled: true,
              //   initialCameraPosition: _kGooglePlex,
              //   polylines: polyLineSet,
              //   markers: markersSet,
              //   circles: circlesSet,
              //   onMapCreated: (GoogleMapController controller) {
              //     _controllerGoogleMap.complete(controller);
              //     newGoogleMapController = controller;

              //     //for black theme google map
              //     ThemesMapUtil.blackThemeGoogleMap(newGoogleMapController);

              //     setState(() {
              //       bottomPaddingOfMap = 240;
              //     });

              //     LocatePosition.locateUserPosition(context, newGoogleMapController, userCurrentPosition, userName, userEmail,
              //         activeNearbyDriverKeysLoaded, setState, markersSet, circlesSet, activeNearbyIcon);
              //   },
              // ),

              //custom hamburger button for drawer
              DrawerButtonWidget(
                openNavigationDrawer: openNavigationDrawer,
                sKey: sKey,
                polyLineSet: polyLineSet,
                markersSet: markersSet,
                circlesSet: circlesSet,
              ),

              //ui for searching location
              RideBoxWidget(
                openNavigationDrawer: openNavigationDrawer,
                polyLineSet: polyLineSet,
                markersSet: markersSet,
                circlesSet: circlesSet,
                updateParentSets: updateSets,
                newGoogleMapController: newGoogleMapController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
