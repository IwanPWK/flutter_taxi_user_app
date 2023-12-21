import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_taxi_user_app/assistants/request_assistant.dart';
import 'package:geolocator/geolocator.dart';

import '../globals/global.dart';
import '../globals/map_key.dart';
import '../models/user_model.dart';

class AssistantMethods {
  static Future<String> searchAddressFromGeographicCoOrdinates(
      Position position, context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if (requestResponse != "Error Occurred, Failed. No Response.") {
      humanReadableAddress = requestResponse["results"][0]
          ["formatted_address"]; //key from documentation geocoding api
    }

    return humanReadableAddress;
  }

  static void readCurrentOnlineUserInfo() async {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
        // print("name: ${userModelCurrentInfo!.name}");
        // print("email: ${userModelCurrentInfo!.email}");
      }
    });
  }
}
