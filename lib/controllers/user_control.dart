import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<FirebaseUser> getCurrentUser(){
    return FirebaseAuth.instance.currentUser();
  }

  Future<String> getDisplayImage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.photoUrl;
  }

  Future<void> updateUserName(String name) async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    UserUpdateInfo updateUser = UserUpdateInfo();
    updateUser.displayName = name;
    await _user.updateProfile(updateUser);
    await _user.reload();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", name);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
