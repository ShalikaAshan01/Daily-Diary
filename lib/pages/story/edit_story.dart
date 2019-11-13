import 'package:daily_diary/controllers/story_controller.dart';
import 'package:daily_diary/model/story.dart';
import 'package:daily_diary/widgets/my_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditStory extends StatefulWidget {
  final Story story;

  const EditStory({Key key, @required this.story}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditStoryState();
}

class _EditStoryState extends State<EditStory> {
  Color _color1 = Color(0xFF233355);
  Color _color2 = Color(0xFF29395A);
  Color _color3 = Color(0xFF294261);
  bool isSaving = false;
  TextEditingController _storyEditingController = TextEditingController();
  List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String story;

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (context) => MyAlert(
                  title: "Are you sure?",
                  content:
                      "Edited story will not be saved and you cannot get it back!",
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('NO'),
                    ),
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('YES'),
                    ),
                  ],
                )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    story = widget.story.story;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = widget.story.date;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: _color1,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Hero(
                tag: "feeling",
                child: Container(
                  padding: EdgeInsets.only(bottom: 5, top: 35, right: 10),
                  alignment: Alignment.topRight,
                  width: double.infinity,
                  child:
                      _feelingsWidget(widget.story.feeling, 90, Colors.white24),
                ),
              ),
              Hero(
                tag: "title",
                child: Container(
                  padding: EdgeInsets.only(left: 22, top: 45),
                  child: Text(
                    "${date.day}, ${_months[date.month - 1]} ${date.year}",
                    style: TextStyle(
                        color: Colors.white24,
                        fontSize: 25,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Hero(
                tag: "cards",
                child: Container(
                  padding: EdgeInsets.only(left: 15, top: 100),
                  child: Row(
                    children: <Widget>[
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: _color3,
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              _work(widget.story.activity),
                              size: 30,
                              color: Colors.white,
                            ),
                          )),
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: _color3,
                          child: Container(
                            width: 60,
                            height: 60,
                            child: _feelingsWidget(
                                widget.story.feeling, 30, Colors.white),
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 200, 10, 10),
                child: Text(
                  "Have you done anything lately worth rembering?"
                      .toUpperCase(),
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 280, 10, 10),
                child: TextField(
                  maxLines: 10,
                  style: Theme.of(context).textTheme.body1,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Edit story to add some text...',
                      hintStyle: Theme.of(context).textTheme.body1),
                  onTap: () {
                    _storyEditingController.text = story;
                  },
                  onChanged: (value) {
                    setState(() {
                      story = value;
                    });
                  },
                  controller: _storyEditingController,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 600, 20, 10),
                width: double.infinity,
                child: RaisedButton.icon(
                  onPressed: () async {
                    Story _story = Story(
                        widget.story.date,
                        story,
                        widget.story.userId,
                        widget.story.feeling,
                        widget.story.activity);
                    _story.image = widget.story.image;
                    _story.createdAt = widget.story.createdAt;
                    _story.updatedAt = DateTime.now();
                    _story.favourite = widget.story.favourite;
                    setState(() {
                      isSaving = true;
                    });
                    await StoryController()
                        .updateStory(_story, widget.story.id);
                    setState(() {
                      isSaving = false;
                    });
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  icon: Container(
                      width: 20,
                      height: 20,
                      child: isSaving
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor))
                          : Container()),
                  label: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Text(
                        isSaving ? "Updating..." : "Update Story".toUpperCase(),
                        style: TextStyle(fontSize: 16)),
                  ),
                  elevation: 4,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _feelingsWidget(int val, double size, Color color) {
    List<IconData> icons = [
      FontAwesomeIcons.tired,
      FontAwesomeIcons.frown,
      FontAwesomeIcons.smile,
      FontAwesomeIcons.grin
    ];
    if (val == 4) val = 3;
    return Container(
      child: Icon(
        icons[val],
        color: color,
        size: size,
      ),
    );
  }

  IconData _work(String _activity) {
    switch (_activity.toLowerCase()) {
      case "work":
        return FontAwesomeIcons.building;
      case "family":
        return FontAwesomeIcons.home;
      case "education":
        return FontAwesomeIcons.graduationCap;
      case "relationship":
        return FontAwesomeIcons.handsHelping;
      case "friends":
        return FontAwesomeIcons.users;
      case "traveling":
        return FontAwesomeIcons.locationArrow;
      case "gaming":
        return FontAwesomeIcons.gamepad;
      case "sports":
        return FontAwesomeIcons.running;
      default:
        return FontAwesomeIcons.boxOpen;
    }
  }
}
