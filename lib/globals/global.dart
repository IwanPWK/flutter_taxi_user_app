import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/direction_details_info.dart';
import '../models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
bool activeNearbyDriverKeysLoaded = false;
BitmapDescriptor? activeNearbyIcon;
List dList = []; //online-active drivers Information List

