// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_handler/app_info.dart';

class DrawerButtonWidget extends StatelessWidget {
  bool openNavigationDrawer;
  // Set<Polyline> polyLineSet;
  // Set<Marker> markersSet;
  // Set<Circle> circlesSet;
  GlobalKey<ScaffoldState> sKey;

  DrawerButtonWidget({
    Key? key,
    required this.openNavigationDrawer,
    // required this.polyLineSet,
    // required this.markersSet,
    // required this.circlesSet,
    required this.sKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 14,
      child: GestureDetector(
        onTap: () {
          if (openNavigationDrawer) {
            sKey.currentState!.openDrawer();
          } else {
            // restart-refresh-minimize app programatically
            // SystemNavigator.pop();
            openNavigationDrawer = true;
            Provider.of<AppInfo>(context, listen: false).clearDropOffLocation();
            // markersSet.clear();
            // circlesSet.clear();
            // polyLineSet.clear();
          }
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            openNavigationDrawer ? Icons.menu : Icons.close,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
