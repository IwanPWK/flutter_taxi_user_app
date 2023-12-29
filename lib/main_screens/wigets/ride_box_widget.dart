// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_taxi_user_app/info_handler/app_info.dart';

import '../../utils/polyline_util.dart';
import '../search_places_screen.dart';

class RideBoxWidget extends StatefulWidget {
  bool openNavigationDrawer;
  Set<Polyline> polyLineSet;
  Set<Marker> markersSet;
  Set<Circle> circlesSet;
  GoogleMapController? newGoogleMapController;
  // final void Function({
  //   required GoogleMapController updGoogleMapController,
  // }) updGoogleMapController;
  final void Function({
    required Set<Polyline> polyLines,
    required Set<Marker> markers,
    required Set<Circle> circles,
  }) updateParentSets;
  RideBoxWidget({
    Key? key,
    required this.openNavigationDrawer,
    required this.polyLineSet,
    required this.markersSet,
    required this.circlesSet,
    this.newGoogleMapController,
    // required this.updGoogleMapController,
    required this.updateParentSets,
  }) : super(key: key);

  @override
  State<RideBoxWidget> createState() => _RideBoxWidgetState();
}

class _RideBoxWidgetState extends State<RideBoxWidget> {
  double searchLocationContainerHeight = 220;
  List<LatLng> pLineCoOrdinatesList = [];
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedSize(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: searchLocationContainerHeight,
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              children: [
                //from
                Stack(
                  children: [
                    Row(children: [
                      const Icon(
                        Icons.add_location_alt_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text(
                          'From',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            Provider.of<AppInfo>(context).userPickUpLocation != null
                                ? Provider.of<AppInfo>(context).userPickUpLocation!.locationName!
                                : "Add pick up",
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ])),
                    ]),
                  ],
                ),

                const SizedBox(height: 10.0),

                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),

                const SizedBox(height: 16.0),

                //to
                GestureDetector(
                  onTap: () async {
                    //go to search places screen

                    var responseFromSearchScreen = await Navigator.push(context, MaterialPageRoute(builder: (c) => SearchPlacesScreen()));

                    setState(() {
                      widget.openNavigationDrawer = false;
                    });
                    print('Gesture Detector!');
                    print('cek respon $responseFromSearchScreen');
                    if (responseFromSearchScreen as String == "obtainedDropoff") {
                      //draw routes - draw polyline
                      print('draw polyline');

                      await PolylineUtils.drawPolyLineFromOriginToDestination(context, pLineCoOrdinatesList, widget.polyLineSet, widget.markersSet,
                          widget.circlesSet, widget.newGoogleMapController, widget.updateParentSets);
                      // PolylineUtils.setState = () {
                      //   setState(() {});
                      // };
                      print('seleai draw polyline');
                    }
                  },
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "To",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                SingleChildScrollView(
                                  child: Text(
                                    Provider.of<AppInfo>(context, listen: false).userDropOffLocation != null
                                        ? Provider.of<AppInfo>(context).userDropOffLocation!.locationName!
                                        : "Where to go?",
                                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10.0),

                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),

                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    if (Provider.of<AppInfo>(context, listen: false).userDropOffLocation != null) {
                      // saveRideRequestInformation();
                    } else {
                      Fluttertoast.showToast(msg: "Please select destination location");
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green, textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  child: const Text(
                    "Request a Ride",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
