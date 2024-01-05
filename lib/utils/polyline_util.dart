import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// import '../app_handler/app_controller.dart';
import '../app_handler/map_handler.dart';
import '../assistants/assistant_methods.dart';
import '../app_handler/app_info.dart';
// import '../globals/global.dart';
import '../models/direction_details_info.dart';
import '../models/directions.dart';
import '../widgets/progress_dialog.dart';

class PolylineUtils {
  static List<LatLng> pLineCoOrdinatesList = [];
  // static Function()? setState;

  static Future<void> drawPolyLineFromOriginToDestination(
    BuildContext context,
  ) async {
    print('halloooo');

    MapHandler mapHandler = Provider.of<MapHandler>(context, listen: false);

    Directions? originPosition = Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
    Directions? destinationPosition = Provider.of<AppInfo>(context, listen: false).userDropOffLocation;
    print('bisakah $destinationPosition');

    var originLatLng = LatLng(originPosition!.locationLatitude!, originPosition.locationLongitude!);
    var destinationLatLng = LatLng(destinationPosition!.locationLatitude!, destinationPosition.locationLongitude!);
    print('latLang $originLatLng, $destinationLatLng');

    showDialog(
      context: context,
      builder: (BuildContext context) => const ProgressDialog(
        message: "Please wait...",
      ),
    );

    DirectionDetailsInfo? directionDetailsInfo = await AssistantMethods.obtainOriginToDestinationDirectionDetails(originLatLng, destinationLatLng);
    mapHandler.setTripDirectionDetailsInfo(directionDetailsInfo!);

    if (context.mounted) Navigator.pop(context);

    print("These are points = ");
    print(directionDetailsInfo.ePoints);

    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResultList = pPoints.decodePolyline(directionDetailsInfo.ePoints!);

    pLineCoOrdinatesList.clear();

    if (decodedPolyLinePointsResultList.isNotEmpty) {
      for (PointLatLng pointLatLng in decodedPolyLinePointsResultList) {
        pLineCoOrdinatesList.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }

    mapHandler.clearPolyLineSet();
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

    if (context.mounted) Provider.of<MapHandler>(context, listen: false).updatePolyLineSet(polyline);
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

    Provider.of<MapHandler>(context, listen: false).cameraUpdateMethod(CameraUpdate.newLatLngBounds(boundsLatLng, 50));

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

    Provider.of<MapHandler>(context, listen: false).updateMarkersSet(originMarker);
    Provider.of<MapHandler>(context, listen: false).updateMarkersSet(destinationMarker);

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

    Provider.of<MapHandler>(context, listen: false).updateCirclesSet(originCircle);
    Provider.of<MapHandler>(context, listen: false).updateCirclesSet(destinationCircle);

    print('lagiii Selesai');
  }
}
