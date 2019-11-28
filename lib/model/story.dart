class Story {
  String id;
  String story;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  int feeling;
  String activity;
  DateTime date;
  String image;
  bool favourite;

  Story(this.date, this.story, this.userId, this.feeling, this.activity);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["favourite"] = favourite;
    map['date'] = date;
    map['story'] = story;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['userId'] = userId;
    map['activity'] = activity;
    map['feelings'] = feeling;
    return map;
  }

  Story.fromMapObject(Map<String, dynamic> map) {
    this.date = map['date'].toDate();
    this.story = map['story'];
    this.createdAt = map['createdAt'].toDate();
    this.updatedAt = map['updatedAt'].toDate();
    this.userId = map['userId'];
    this.activity = map['activity'];
    this.feeling = map['feelings'];
    this.image = map['image'] != null
        ? map['image']
        : "https://images.pexels.com/photos/55787/pexels-photo-55787.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260";
    this.favourite = map['favourite'];
  }
}
