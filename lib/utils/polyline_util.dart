import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../assistants/assistant_methods.dart';
import '../info_handler/app_info.dart';
import '../widgets/progress_dialog.dart';

class PolylineUtils {
  // static Function()? setState;

  static Future<void> drawPolyLineFromOriginToDestination(
    BuildContext context,
    List<LatLng> pLineCoOrdinatesList,
    Set<Polyline> polyLineSet,
    Set<Marker> markersSet,
    Set<Circle> circlesSet,
    GoogleMapController? newGoogleMapController,
    void Function({
      required Set<Polyline> polyLines,
      required Set<Marker> markers,
      required Set<Circle> circles,
    }) updateParentSets,
  ) async {
    print('halloooo');
    var originPosition = Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
    var destinationPosition = Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

    var originLatLng = LatLng(originPosition!.locationLatitude!, originPosition.locationLongitude!);
    var destinationLatLng = LatLng(destinationPosition!.locationLatitude!, destinationPosition.locationLongitude!);

    showDialog(
      context: context,
      builder: (BuildContext context) => const ProgressDialog(
        message: "Please wait...",
      ),
    );

    var directionDetailsInfo = await AssistantMethods.obtainOriginToDestinationDirectionDetails(originLatLng, destinationLatLng);

    Navigator.pop(context);

    print("These are points = ");
    print(directionDetailsInfo!.ePoints);

    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResultList = pPoints.decodePolyline(directionDetailsInfo.ePoints!);

    pLineCoOrdinatesList.clear();

    if (decodedPolyLinePointsResultList.isNotEmpty) {
      for (PointLatLng pointLatLng in decodedPolyLinePointsResultList) {
        pLineCoOrdinatesList.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }

    polyLineSet.clear();
    print('lagiii');

    Polyline polyline = Polyline(
      color: Colors.orange,
      polylineId: const PolylineId("PolylineID"),
      jointType: JointType.round,
      points: pLineCoOrdinatesList,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
      width: 5,
    );
    print('lagiii ku');

    polyLineSet.add(polyline);
    print('lagiii po');

    LatLngBounds boundsLatLng;
    if (originLatLng.latitude > destinationLatLng.latitude && originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng = LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
        northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude),
      );
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
        northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      boundsLatLng = LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }

    print('lagiii la');

    newGoogleMapController!.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 50));

    print('lagiii ka');

    Marker originMarker = Marker(
      markerId: const MarkerId("originID"),
      infoWindow: InfoWindow(title: originPosition.locationName, snippet: "Origin"),
      position: originLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId("destinationID"),
      infoWindow: InfoWindow(title: destinationPosition.locationName, snippet: "Destination"),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    // setState(() {
    //   markersSet.add(originMarker);
    //   markersSet.add(destinationMarker);
    // });
    markersSet.add(originMarker);
    markersSet.add(destinationMarker);

    print('lagiii yu');

    Circle originCircle = Circle(
      circleId: const CircleId("originID"),
      fillColor: Colors.green,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: originLatLng,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId("destinationID"),
      fillColor: Colors.red,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: destinationLatLng,
    );

    // setState(() {
    //   circlesSet.add(originCircle);
    //   circlesSet.add(destinationCircle);
    // });
    circlesSet.add(originCircle);
    circlesSet.add(destinationCircle);

    updateParentSets(
      polyLines: polyLineSet,
      markers: markersSet,
      circles: circlesSet,
    );
    // setState!();

    print('Cek $updateParentSets');
  }
}
