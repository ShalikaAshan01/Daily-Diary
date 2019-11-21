import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/model/story.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryController {
  final String _mainCollection = "stories";

  Future<DocumentReference> saveStory(Story story) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(_mainCollection)
        .where('date', isEqualTo: story.date)
        .where('userId', isEqualTo: story.userId)
        .limit(1)
        .getDocuments();
    if (snapshot.documents.length <= 0)
      return Firestore.instance.collection(_mainCollection).add(story.toMap());
    else {
      DocumentSnapshot documentSnapshot = snapshot.documents.removeLast();
      story.createdAt = documentSnapshot.data["createdAt"].toDate();
      await documentSnapshot.reference.updateData(story.toMap());
      return documentSnapshot.reference;
    }
  }

  Stream<QuerySnapshot> getStories(String userId) {
    return Firestore.instance
        .collection(_mainCollection)
        .where('userId', isEqualTo: userId)
        .orderBy("date", descending: true)
        .snapshots();
  }

  void updateFavouriteItem(bool value, String id) async {
    await Firestore.instance.collection(_mainCollection)
        .document(id)
        .updateData({
      "favourite": value
    });
  }

  Future<void> deleteStory(String id) async {
    return await Firestore.instance.collection(_mainCollection)
        .document(id)
        .delete();
  }

  Future<void> updateStory(Story _story, String id) async {
    return await Firestore.instance.collection(_mainCollection).document(id)
        .updateData(_story.toMap());
  }

  Stream<QuerySnapshot> getFavourites(String userId) {
    return Firestore.instance
        .collection(_mainCollection)
        .where('userId', isEqualTo: userId)
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<List> getCounts() async {
    FirebaseUser user = await UserControl().getCurrentUser();
    QuerySnapshot totalSnap = await Firestore.instance.collection(
        _mainCollection).where("userId", isEqualTo: user.uid).getDocuments();
    QuerySnapshot favSnap = await Firestore.instance.collection(_mainCollection)
        .where("userId", isEqualTo: user.uid).where(
        "favourite", isEqualTo: true)
        .getDocuments();
    return [totalSnap.documents.length, favSnap.documents.length];
  }

}
