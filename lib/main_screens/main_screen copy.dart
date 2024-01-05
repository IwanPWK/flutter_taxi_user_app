// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_geofire/flutter_geofire.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_taxi_user_app/main_screens/search_places_screen.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:provider/provider.dart';
// import '../assistants/assistant_methods.dart';
// import '../assistants/geofire_assistant.dart';
// import '../globals/global.dart';
// import '../app_handler/app_info.dart';
// import '../models/active_nearby_available_drivers.dart';
// import '../widgets/drawer.dart';
// import '../widgets/progress_dialog.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   late StreamSubscription listener;
//   bool isDeviceConnected = false;
//   bool isAlertSet = false;
//   final Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   GoogleMapController? newGoogleMapController;

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
//   double searchLocationContainerHeight = 220;

//   Position? userCurrentPosition;
//   var geoLocator = Geolocator();

//   // LocationPermission? _locationPermission; //asked permission
//   double bottomPaddingOfMap = 0;

//   List<LatLng> pLineCoOrdinatesList = [];
//   Set<Polyline> polyLineSet = {};

//   Set<Marker> markersSet = {};
//   Set<Circle> circlesSet = {};

//   String userName = "your Name";
//   String userEmail = "your Email";

//   bool openNavigationDrawer = true;

//   bool activeNearbyDriverKeysLoaded = false;

//   BitmapDescriptor? activeNearbyIcon;

//   blackThemeGoogleMap() {
//     newGoogleMapController!.setMapStyle('''
//                     [
//                       {
//                         "elementType": "geometry",
//                         "stylers": [
//                           {
//                             "color": "#242f3e"
//                           }
//                         ]
//                       },
//                       {
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#746855"
//                           }
//                         ]
//                       },
//                       {
//                         "elementType": "labels.text.stroke",
//                         "stylers": [
//                           {
//                             "color": "#242f3e"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "administrative.locality",
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#d59563"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "poi",
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#d59563"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "poi.park",
//                         "elementType": "geometry",
//                         "stylers": [
//                           {
//                             "color": "#263c3f"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "poi.park",
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#6b9a76"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "road",
//                         "elementType": "geometry",
//                         "stylers": [
//                           {
//                             "color": "#38414e"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "road",
//                         "elementType": "geometry.stroke",
//                         "stylers": [
//                           {
//                             "color": "#212a37"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "road",
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#9ca5b3"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "road.highway",
//                         "elementType": "geometry",
//                         "stylers": [
//                           {
//                             "color": "#746855"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "road.highway",
//                         "elementType": "geometry.stroke",
//                         "stylers": [
//                           {
//                             "color": "#1f2835"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "road.highway",
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#f3d19c"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "transit",
//                         "elementType": "geometry",
//                         "stylers": [
//                           {
//                             "color": "#2f3948"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "transit.station",
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#d59563"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "water",
//                         "elementType": "geometry",
//                         "stylers": [
//                           {
//                             "color": "#17263c"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "water",
//                         "elementType": "labels.text.fill",
//                         "stylers": [
//                           {
//                             "color": "#515c6d"
//                           }
//                         ]
//                       },
//                       {
//                         "featureType": "water",
//                         "elementType": "labels.text.stroke",
//                         "stylers": [
//                           {
//                             "color": "#17263c"
//                           }
//                         ]
//                       }
//                     ]
//                 ''');
//   }

//   //asked permission
//   // checkIfLocationPermissionAllowed() async {
//   //   _locationPermission = await Geolocator.requestPermission();

//   //   if (_locationPermission == LocationPermission.denied) {
//   //     _locationPermission = await Geolocator.requestPermission();
//   //   }
//   // }

//   locateUserPosition() async {
//     Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     userCurrentPosition = cPosition;

//     LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

//     CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

//     newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

//     String humanReadableAddress = await AssistantMethods.searchAddressFromGeographicCoOrdinates(userCurrentPosition!, context);
//     print("this is your address = " + humanReadableAddress);

//     userName = userModelCurrentInfo!.name!;
//     userEmail = userModelCurrentInfo!.email!;

//     initializeGeoFireListener();
//   }

//   Future<void> checkIfNetworkIsAvailable() async {
//     listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
//       if (status == InternetStatus.disconnected && isAlertSet == false) {
//         showDialogBox();
//         setState(() => isAlertSet = true);
//       }
//     });
//   }

//   @override
//   void initState() {
//     checkIfNetworkIsAvailable();

//     super.initState();
//   }

//   @override
//   dispose() {
//     listener.cancel();
//     super.dispose();
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //asked permission
//   // checkIfLocationPermissionAllowed(); kesalahan dikarenakan memanggil checkIfLocationPermissionAllowed di file main_screen.dart
//   //karena sebagai permission telat untuk meminta permission, karena map sudah terlanjut di load
//   // }

//   @override
//   Widget build(BuildContext context) {
//     createActiveNearByDriverIconMarker();
//     return WillPopScope(
//       onWillPop: () async {
//         if (!openNavigationDrawer) {
//           openNavigationDrawer = true;
//           Provider.of<AppInfo>(context, listen: false).clearDropOffLocation();
//           setState(() {
//             markersSet.clear();
//             circlesSet.clear();
//             polyLineSet.clear();
//           });

//           return false;
//         } else {
//           final shouldPop = await showDialog<bool>(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text('Do you want to exit and logout?'),
//                 actionsAlignment: MainAxisAlignment.spaceBetween,
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       fAuth.signOut();
//                       Navigator.pop(context, true);
//                     },
//                     child: const Text('Yes'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context, false);
//                     },
//                     child: const Text('No'),
//                   ),
//                 ],
//               );
//             },
//           );
//           return shouldPop!;
//         }
//       },
//       child: Scaffold(
//         key: sKey,
//         drawer: SizedBox(
//           width: 265,
//           child: Theme(
//             data: Theme.of(context).copyWith(
//               canvasColor: Colors.black,
//             ),
//             child: DrawerWidget(
//               name: userName,
//               email: userEmail,
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               GoogleMap(
//                 padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
//                 mapType: MapType.normal,
//                 myLocationEnabled: true,
//                 zoomGesturesEnabled: true,
//                 zoomControlsEnabled: true,
//                 initialCameraPosition: _kGooglePlex,
//                 polylines: polyLineSet,
//                 markers: markersSet,
//                 circles: circlesSet,
//                 onMapCreated: (GoogleMapController controller) {
//                   _controllerGoogleMap.complete(controller);
//                   newGoogleMapController = controller;

//                   //for black theme google map
//                   blackThemeGoogleMap();

//                   setState(() {
//                     bottomPaddingOfMap = 240;
//                   });

//                   locateUserPosition();
//                 },
//               ),

//               //custom hamburger button for drawer
//               Positioned(
//                 top: 30,
//                 left: 14,
//                 child: GestureDetector(
//                   onTap: () {
//                     if (openNavigationDrawer) {
//                       sKey.currentState!.openDrawer();
//                     } else {
//                       // restart-refresh-minimize app programatically
//                       // SystemNavigator.pop();
//                       openNavigationDrawer = true;
//                       Provider.of<AppInfo>(context, listen: false).clearDropOffLocation();
//                       markersSet.clear();
//                       circlesSet.clear();
//                       polyLineSet.clear();
//                     }
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey,
//                     child: Icon(
//                       openNavigationDrawer ? Icons.menu : Icons.close,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//               ),

//               //ui for searching location
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: AnimatedSize(
//                   curve: Curves.easeIn,
//                   duration: const Duration(milliseconds: 120),
//                   child: Container(
//                     height: searchLocationContainerHeight,
//                     decoration: const BoxDecoration(
//                       color: Colors.black87,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(20),
//                         topLeft: Radius.circular(20),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
//                       child: Column(
//                         children: [
//                           //from
//                           Stack(
//                             children: [
//                               Row(children: [
//                                 const Icon(
//                                   Icons.add_location_alt_outlined,
//                                   color: Colors.grey,
//                                 ),
//                                 const SizedBox(
//                                   width: 12.0,
//                                 ),
//                                 Expanded(
//                                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                                   const Text(
//                                     'From',
//                                     style: TextStyle(color: Colors.grey, fontSize: 12),
//                                   ),
//                                   SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Text(
//                                       Provider.of<AppInfo>(context).userPickUpLocation != null
//                                           ? Provider.of<AppInfo>(context).userPickUpLocation!.locationName!
//                                           : "Add pick up",
//                                       style: const TextStyle(color: Colors.grey, fontSize: 14),
//                                     ),
//                                   ),
//                                 ])),
//                               ]),
//                             ],
//                           ),

//                           const SizedBox(height: 10.0),

//                           const Divider(
//                             height: 1,
//                             thickness: 1,
//                             color: Colors.grey,
//                           ),

//                           const SizedBox(height: 16.0),

//                           //to
//                           GestureDetector(
//                             onTap: () async {
//                               //go to search places screen

//                               var responseFromSearchScreen = await Navigator.push(context, MaterialPageRoute(builder: (c) => SearchPlacesScreen()));

//                               setState(() {
//                                 openNavigationDrawer = false;
//                               });

//                               if (responseFromSearchScreen as String == "obtainedDropoff") {
//                                 //draw routes - draw polyline
//                                 await drawPolyLineFromOriginToDestination();
//                               }
//                             },
//                             child: Stack(
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.add_location_alt_outlined,
//                                       color: Colors.grey,
//                                     ),
//                                     const SizedBox(
//                                       width: 12.0,
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           const Text(
//                                             "To",
//                                             style: TextStyle(color: Colors.grey, fontSize: 12),
//                                           ),
//                                           SingleChildScrollView(
//                                             child: Text(
//                                               Provider.of<AppInfo>(context).userDropOffLocation != null
//                                                   ? Provider.of<AppInfo>(context).userDropOffLocation!.locationName!
//                                                   : "Where to go?",
//                                               style: const TextStyle(color: Colors.grey, fontSize: 14),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 10.0),

//                           const Divider(
//                             height: 1,
//                             thickness: 1,
//                             color: Colors.grey,
//                           ),

//                           const SizedBox(height: 16.0),

//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green, textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             child: const Text(
//                               "Request a Ride",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> drawPolyLineFromOriginToDestination() async {
//     var originPosition = Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
//     var destinationPosition = Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

//     var originLatLng = LatLng(originPosition!.locationLatitude!, originPosition.locationLongitude!);
//     var destinationLatLng = LatLng(destinationPosition!.locationLatitude!, destinationPosition.locationLongitude!);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) => const ProgressDialog(
//         message: "Please wait...",
//       ),
//     );

//     var directionDetailsInfo = await AssistantMethods.obtainOriginToDestinationDirectionDetails(originLatLng, destinationLatLng);

//     Navigator.pop(context);

//     print("These are points = ");
//     print(directionDetailsInfo!.ePoints);

//     PolylinePoints pPoints = PolylinePoints();
//     List<PointLatLng> decodedPolyLinePointsResultList = pPoints.decodePolyline(directionDetailsInfo.ePoints!);

//     pLineCoOrdinatesList.clear();

//     if (decodedPolyLinePointsResultList.isNotEmpty) {
//       for (PointLatLng pointLatLng in decodedPolyLinePointsResultList) {
//         pLineCoOrdinatesList.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
//       }
//     }

//     polyLineSet.clear();

//     setState(() {
//       Polyline polyline = Polyline(
//         color: Colors.orange,
//         polylineId: const PolylineId("PolylineID"),
//         jointType: JointType.round,
//         points: pLineCoOrdinatesList,
//         startCap: Cap.roundCap,
//         endCap: Cap.roundCap,
//         geodesic: true,
//         width: 5,
//       );

//       polyLineSet.add(polyline);
//     });

//     LatLngBounds boundsLatLng;
//     if (originLatLng.latitude > destinationLatLng.latitude && originLatLng.longitude > destinationLatLng.longitude) {
//       boundsLatLng = LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
//     } else if (originLatLng.longitude > destinationLatLng.longitude) {
//       boundsLatLng = LatLngBounds(
//         southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
//         northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude),
//       );
//     } else if (originLatLng.latitude > destinationLatLng.latitude) {
//       boundsLatLng = LatLngBounds(
//         southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
//         northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude),
//       );
//     } else {
//       boundsLatLng = LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
//     }

//     newGoogleMapController!.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 50));

//     Marker originMarker = Marker(
//       markerId: const MarkerId("originID"),
//       infoWindow: InfoWindow(title: originPosition.locationName, snippet: "Origin"),
//       position: originLatLng,
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
//     );

//     Marker destinationMarker = Marker(
//       markerId: const MarkerId("destinationID"),
//       infoWindow: InfoWindow(title: destinationPosition.locationName, snippet: "Destination"),
//       position: destinationLatLng,
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//     );

//     setState(() {
//       markersSet.add(originMarker);
//       markersSet.add(destinationMarker);
//     });

//     Circle originCircle = Circle(
//       circleId: const CircleId("originID"),
//       fillColor: Colors.green,
//       radius: 12,
//       strokeWidth: 3,
//       strokeColor: Colors.white,
//       center: originLatLng,
//     );

//     Circle destinationCircle = Circle(
//       circleId: const CircleId("destinationID"),
//       fillColor: Colors.red,
//       radius: 12,
//       strokeWidth: 3,
//       strokeColor: Colors.white,
//       center: destinationLatLng,
//     );

//     setState(() {
//       circlesSet.add(originCircle);
//       circlesSet.add(destinationCircle);
//     });
//   }

//   showDialogBox() => showCupertinoDialog<String>(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: const Text('No Connection'),
//           content: const Text('Please check your internet connectivity'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context, 'Cancel');
//                 setState(() => isAlertSet = false);
//                 isDeviceConnected = await InternetConnection().hasInternetAccess;
//                 if (!isDeviceConnected && isAlertSet == false) {
//                   showDialogBox();
//                   setState(() => isAlertSet = true);
//                 }
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );

//   initializeGeoFireListener() {
//     Geofire.initialize("activeDrivers");
//     Geofire.queryAtLocation(userCurrentPosition!.latitude, userCurrentPosition!.longitude, 10)!.listen((map) {
//       print('cek map $map');
//       if (map != null) {
//         var callBack = map['callBack'];

//         //latitude will be retrieved from map['latitude']
//         //longitude will be retrieved from map['longitude']

//         switch (callBack) {
//           case Geofire.onKeyEntered:
//             ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
//             activeNearbyAvailableDriver.locationLatitude = map['latitude'];
//             activeNearbyAvailableDriver.locationLongitude = map['longitude'];
//             activeNearbyAvailableDriver.driverId = map['key'];
//             GeoFireAssistant.activeNearbyAvailableDriversList.add(activeNearbyAvailableDriver);
//             if (activeNearbyDriverKeysLoaded == true) {
//               displayActiveDriversOnUsersMap();
//             }
//             break;

//           //whenever any driver become non-active/offline
//           case Geofire.onKeyExited:
//             GeoFireAssistant.deleteOfflineDriverFromList(map['key']);
//             displayActiveDriversOnUsersMap();
//             break;

//           //whenever driver moves - update driver location
//           case Geofire.onKeyMoved:
//             ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
//             activeNearbyAvailableDriver.locationLatitude = map['latitude'];
//             activeNearbyAvailableDriver.locationLongitude = map['longitude'];
//             activeNearbyAvailableDriver.driverId = map['key'];
//             GeoFireAssistant.updateActiveNearbyAvailableDriverLocation(activeNearbyAvailableDriver);
//             displayActiveDriversOnUsersMap();
//             break;

//           //display those online/active drivers on user's map
//           case Geofire.onGeoQueryReady:
//             activeNearbyDriverKeysLoaded = true;
//             displayActiveDriversOnUsersMap();
//             break;
//         }
//       }

//       setState(() {});
//     });
//   }

//   displayActiveDriversOnUsersMap() {
//     setState(() {
//       markersSet.clear();
//       circlesSet.clear();

//       Set<Marker> driversMarkerSet = Set<Marker>();

//       for (ActiveNearbyAvailableDrivers eachDriver in GeoFireAssistant.activeNearbyAvailableDriversList) {
//         LatLng eachDriverActivePosition = LatLng(eachDriver.locationLatitude!, eachDriver.locationLongitude!);

//         Marker marker = Marker(
//           markerId: MarkerId("driver" + eachDriver.driverId!),
//           position: eachDriverActivePosition,
//           icon: activeNearbyIcon!,
//           rotation: 360,
//         );

//         driversMarkerSet.add(marker);
//       }

//       setState(() {
//         markersSet = driversMarkerSet;
//       });
//     });
//   }

//   createActiveNearByDriverIconMarker() {
//     if (activeNearbyIcon == null) {
//       ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: const Size(2, 2));
//       BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car.png").then((value) {
//         activeNearbyIcon = value;
//       });
//     }
//   }
// }
