class Story {
  String _id;
  String _story;
  DateTime _createdAt;
  DateTime _updatedAt;
  String _userId;
  int _feeling;
  String _activity;
  DateTime _date;
  String _image;
  bool _favourite;

  Story(this._date, this._story, this._userId, this._feeling, this._activity);

  set story(String value) {
    _story = value;
  }


  String get image => _image;

  set image(String value) {
    _image = value;
  }


  bool get favourite => _favourite;

  set favourite(bool value) {
    _favourite = value;
  }

  String get activity => _activity;

  int get feeling => _feeling;

  String get userId => _userId;

  DateTime get updatedAt => _updatedAt;

  DateTime get createdAt => _createdAt;

  String get story => _story;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  set feeling(int value) {
    _feeling = value;
  }

  set activity(String value) {
    _activity = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["favourite"] = _favourite;
    map['date'] = _date;
    map['story'] = _story;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['userId'] = _userId;
    map['activity'] = _activity;
    map['feelings'] = _feeling;
    return map;
  }

  Story.fromMapObject(Map<String, dynamic> map) {
    this._date = map['date'].toDate();
    this._story = map['story'];
    this._createdAt = map['createdAt'].toDate();
    this.updatedAt = map['updatedAt'].toDate();
    this._userId = map['userId'];
    this._activity = map['activity'];
    this._feeling = map['feelings'];
    this._image = map['image'] != null
        ? map['image']
        : "https://images.pexels.com/photos/1633413/pexels-photo-1633413.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    this.favourite = map['favourite'];
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }
}
