import 'package:daily_diary/controllers/story_controller.dart';
import 'package:daily_diary/model/story.dart';
import 'package:daily_diary/pages/story/edit_story.dart';
import 'package:daily_diary/widgets/my_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowStory extends StatefulWidget {
  final Story story;

  const ShowStory({Key key, @required this.story}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowStoryState();
}

class _ShowStoryState extends State<ShowStory> {
  Color _color1 = Color(0xFF233355);
  Color _color2 = Color(0xFF29395A);
  Color _color3 = Color(0xFF294261);
  bool showMenu = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color1,
      body: Stack(
        children: <Widget>[
          Hero(
              tag: "feeling", child: _buildFeeling()),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    Size size = MediaQuery.of(context).size;
    DateTime date = widget.story.date;
    return Container(
      width: double.infinity,
      height: size.height,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Hero(
            tag: widget.story.id,
            flightShuttleBuilder: (BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext) =>
                Material(
                    color: Colors.transparent, child: toHeroContext.widget),
            child: Container(
              width: size.width * 0.4,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.height * 0.1),
                  bottomRight: Radius.circular(size.height * 0.1),
                ),
                image: DecorationImage(
                    image: NetworkImage(widget.story.image), fit: BoxFit.cover),
              ),
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 20, left: 5, right: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 10,
                          color: _color3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_downward,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showMenu = !showMenu;
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 10,
                          color: _color3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 2000),
                              child: showMenu
                                  ? Icon(
                                FontAwesomeIcons.times,
                                size: 25,
                                color: Colors.white,
                              )
                                  : Icon(
                                FontAwesomeIcons.ellipsisV,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _menuItem(Icons.edit, () {
                    if (showMenu)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              EditStory(story: widget.story,)));
                  }),
                  _menuItem(Icons.delete, () {
                    if (showMenu) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return MyAlert(
                              title: "Are you sure?",
                              content: "Are you certain you want to delete this story? This action is irreversible and the story will be lost forever!",
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    await StoryController().deleteStory(
                                        widget.story.id);
                                    Navigator.of(context).popUntil((
                                        route) => route.isFirst);
                                  },
                                ),
                                FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),

                              ],
                            );
                          }
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
          Hero(
            tag: "title",
            child: Container(
              padding: EdgeInsets.only(left: 22, top: 25),
              child: Text(
                "${date.day}, ${_months[date.month - 1]} ${date.year}",
                style: TextStyle(color: Colors.white24,
                    fontSize: 22,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          Hero(
            tag: "cards",
            child: Container(
              padding: EdgeInsets.only(left: 25, top: 25),
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
          GestureDetector(
            onTap: () {
              //todo add edit story
            },
            child: Container(
              padding: EdgeInsets.only(top: 80, left: 30, right: 30),
              child: Text(
                widget.story.story.isNotEmpty
                    ? widget.story.story
                    : "Edit Story to add some text...",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          )
        ],
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

  Widget _menuItem(IconData _icon, onTap) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: showMenu ? 1 : 0,
      child: Container(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 10,
            color: _color3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                _icon,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeeling() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: _color1,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 18),
      child: _feelingsWidget(widget.story.feeling, 100, Colors.white54),
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
}
