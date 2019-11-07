class Story {
  String _id;
  String _story;
  DateTime _createdAt;
  DateTime _updatedAt;
  String _userId;
  int _feeling;
  String _activity;
  String _date;

  Story(this._date, this._story, this._userId, this._feeling, this._activity);

  set story(String value) {
    _story = value;
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
    this._date = map['date'];
    this._story = map['story'];
    this._createdAt = map['createdAt'];
    this.updatedAt = map['updatedAt'];
    this._userId = map['userId'];
    this._activity = map['activity'];
    this._feeling = map['feelings'];
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }
}
