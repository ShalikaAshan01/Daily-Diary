import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_diary/model/story.dart';
import 'package:flutter/cupertino.dart';

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
}
