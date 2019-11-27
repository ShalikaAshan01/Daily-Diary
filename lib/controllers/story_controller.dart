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
    await Firestore.instance
        .collection(_mainCollection)
        .document(id)
        .updateData({"favourite": value});
  }

  Future<void> deleteStory(String id) async {
    return await Firestore.instance
        .collection(_mainCollection)
        .document(id)
        .delete();
  }

  Future<void> updateStory(Story _story, String id) async {
    return await Firestore.instance
        .collection(_mainCollection)
        .document(id)
        .updateData(_story.toMap());
  }

  Stream<QuerySnapshot> getFavourites(String userId) {
    return Firestore.instance
        .collection(_mainCollection)
        .where('userId', isEqualTo: userId)
        .where('favourite', isEqualTo: true)
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<List> getCounts() async {
    FirebaseUser user = await UserControl().getCurrentUser();
    QuerySnapshot totalSnap = await Firestore.instance
        .collection(_mainCollection)
        .where("userId", isEqualTo: user.uid)
        .getDocuments();
    QuerySnapshot favSnap = await Firestore.instance
        .collection(_mainCollection)
        .where("userId", isEqualTo: user.uid)
        .where("favourite", isEqualTo: true)
        .getDocuments();
    return [totalSnap.documents.length, favSnap.documents.length];
  }

  Future<List<Story>> getStoriesAsList() async {
    FirebaseUser user = await UserControl().getCurrentUser();
    QuerySnapshot snapshot = await Firestore.instance
        .collection(_mainCollection)
        .where('userId', isEqualTo: user.uid)
        .orderBy("date", descending: true)
        .getDocuments();

    List<Story> stories = List();

    for (int i = 0; i < snapshot.documents.length; i++) {
      stories.add(Story.fromMapObject(snapshot.documents[i].data));
    }
    return stories;
  }

  Future<List<int>> getRate() async {
    FirebaseUser user = await UserControl().getCurrentUser();
    DateTime date = DateTime.now().subtract(Duration(days: 31));
    QuerySnapshot snapshot = await Firestore.instance
        .collection(_mainCollection)
        .where("userId", isEqualTo: user.uid)
        .where("date", isGreaterThan: date)
        .orderBy("date", descending: false)
        .getDocuments();
    Story temp;
    List<int> feelings = List.filled(31, 0);
    for (int i = 0; i < snapshot.documents.length; i++) {
      temp = Story.fromMapObject(snapshot.documents[i].data);
      feelings[temp.date.weekday - 1] = temp.feeling + 1;
    }
    return feelings;
  }

  Future<List<int>> getActivityCount(int days) async {
    FirebaseUser user = await UserControl().getCurrentUser();
    DateTime date = DateTime.now().subtract(Duration(days: days));
    QuerySnapshot snapshot = await Firestore.instance
        .collection(_mainCollection)
        .where("userId", isEqualTo: user.uid)
        .where("date", isGreaterThan: date)
        .orderBy("date", descending: false)
        .getDocuments();
    String temp;
    List<int> activity = List.filled(9, 0);
    for (int i = 0; i < snapshot.documents.length; i++) {
      temp = Story
          .fromMapObject(snapshot.documents[i].data)
          .activity;

      switch (temp.toLowerCase()) {
        case "work":
          activity[0]++;
          break;
        case "family":
          activity[1]++;
          break;
        case "education":
          activity[2]++;
          break;
        case "relationship":
          activity[3]++;
          break;
        case "friends":
          activity[4]++;
          break;
        case "traveling":
          activity[5]++;
          break;
        case "gaming":
          activity[6]++;
          break;
        case "sports":
          activity[7]++;
          break;
        default:
          activity[8]++;
          break;
      }
    }
    return activity;
  }
}
