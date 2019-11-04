import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserControl {
  final Firestore _firestore = Firestore.instance;

  Future<void> onSignIn(String _id, String _name) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").document(_id).get();
    if (!documentSnapshot.exists) {
      _firestore.collection("users").document(_id).setData({"name": _name});
    } else {
      _name = documentSnapshot.data["name"];
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", _name);
  }

  Future<String> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("name");
  }
}
