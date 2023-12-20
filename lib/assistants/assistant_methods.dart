import 'package:firebase_database/firebase_database.dart';
import '../globals/global.dart';
import '../models/user_model.dart';

class AssistantMethods {
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
