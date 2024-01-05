import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../app_handler/map_handler.dart';
import '../globals/global.dart';
import '../app_handler/app_info.dart';
import '../utils/check_network_util.dart';
// import '../utils/icon_marker_util.dart';
import '../utils/icon_marker_util.dart';
import '../widgets/drawer.dart';
import 'wigets/drawer_button_widget.dart';
import 'wigets/google_map_widget.dart';
import 'wigets/ride_box_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  Position? userCurrentPosition;

  bool activeNearbyDriverKeysLoaded = false;

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    IconMarkerUtil.createActiveNearByDriverIconMarker(context);
    print('userDropOffLocation is ${Provider.of<AppInfo>(context, listen: false).userDropOffLocation == null}');
    return WillPopScope(
      onWillPop: () async {
        if (Provider.of<AppInfo>(context, listen: false).userDropOffLocation != null) {
          print('userDropOffLocation is null');
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
            child: DrawerWidget(),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              const CheckNetworkUtil(),
              GoogleMapWidget(),

              //custom hamburger button for drawer
              DrawerButtonWidget(
                sKey: sKey,
              ),

              //ui for searching location
              RideBoxWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
