import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_diary/controllers/story_controller.dart';
import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/model/story.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:daily_diary/widgets/my_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddStories2 extends StatefulWidget {
  final DateTime date;

  const AddStories2({Key key, this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddStories2State();
}

class _AddStories2State extends State<AddStories2> {
  IconData _feelingsIcon = FontAwesomeIcons.smile;
  double _value = 2;
  String _feelings = "completely okay";
  PageController _controller =
      PageController(viewportFraction: 1, keepPage: true);
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
  String _activity = "OTHER";
  bool isSaving = false;

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) =>
            MyAlert(
              title: "Are you sure?",
              content:
              "This story will not be saved and you cannot get it back!",
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('CANCEL'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('OK'),
                ),
              ],
            )) ??
        false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [_primary, _accent],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                _firstPage(),
                _secondPage(),
                _thirdPage(),
                _fourthPage(),
                _fifthPage()
              ],
            ),
          )),
    );
  }

  Widget _firstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        _glowLogo(100),
        Container(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              "How was your day?",
              style: TextStyle(color: Colors.white70, fontSize: 25),
            )),
        Spacer(),
        Center(
            child: Icon(
          _feelingsIcon,
          size: 100,
          color: Colors.white30,
        )),
        SizedBox(
          height: 50,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Theme.of(context).accentColor,
              trackHeight: 3.0,
              thumbColor: Colors.white,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
              overlayColor: Theme.of(context).primaryColor,
              activeTickMarkColor: Colors.white,
              inactiveTickMarkColor: Theme.of(context).accentColor,
              overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
            ),
            child: Slider(
              value: _value,
              min: 0.0,
              max: 4.0,
              divisions: 4,
              onChanged: (double value) {
                setState(() {
                  _value = value;
                  _feelingsIcon = _emoji(value);
                });
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Row(
            children: <Widget>[
              Text(
                "rate your date".toUpperCase(),
                style: TextStyle(color: Colors.white30),
              ),
              Spacer(),
              Text(
                _feelings.toUpperCase(),
                style: TextStyle(color: Colors.white60),
              ),
            ],
          ),
        ),
        Spacer(),
        Spacer(),
        Spacer(),
        _bottomArrows(-1, 1),
      ],
    );
  }

  Widget _secondPage() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _glowLogo(180),
          Container(
            width: double.maxFinite,
            height: 300,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 2 / 1.5,
              crossAxisCount: 3,
              children: <Widget>[
                _secondPageItem(FontAwesomeIcons.building, "work"),
                _secondPageItem(FontAwesomeIcons.home, "family"),
                _secondPageItem(FontAwesomeIcons.graduationCap, "education"),
                _secondPageItem(FontAwesomeIcons.handsHelping, "relationship"),
                _secondPageItem(FontAwesomeIcons.users, "friends"),
                _secondPageItem(FontAwesomeIcons.locationArrow, "traveling"),
                _secondPageItem(FontAwesomeIcons.gamepad, "gaming"),
                _secondPageItem(FontAwesomeIcons.running, "sports"),
                _secondPageItem(FontAwesomeIcons.boxOpen, "other"),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            _activity,
            style: TextStyle(fontSize: 22),
          )),
          Spacer(),
          _bottomArrows(0, 2)
        ],
      ),
    );
  }

  Widget _secondPageItem(IconData _iconData, String _text) {
    Color _inactiveColor = Colors.white;
    Color color = _inactiveColor;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activity = _text.toUpperCase();
        });
      },
      child: Column(
        children: <Widget>[
          Icon(
            _iconData,
            color: color,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            _text.toLowerCase(),
            style: TextStyle(color: color, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget _thirdPage() {
    return Column(
      children: <Widget>[
        Container(alignment: Alignment.bottomLeft, child: _glowLogo(180)),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            "Would you like to elaborate on what happend?",
            style: TextStyle(fontSize: 30),
          ),
        ),
        Spacer(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(25),
          child: RaisedButton(
            onPressed: () {
              _controller.jumpToPage(3);
            },
            child: Text("YES!", style: TextStyle(fontSize: 16)),
            elevation: 12,
            color: Colors.white,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(25),
          child: GestureDetector(
              onTap: () => _controller.jumpToPage(4),
              child: Text("no thanks!".toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white60))),
        ),
        Spacer(),
        _bottomArrows(1, 3)
      ],
    );
  }

  Widget _fourthPage() {
    return ListView(
      children: <Widget>[
        Container(alignment: Alignment.bottomLeft, child: _glowLogo(180)),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            "Would you like to elaborate on what happend?",
            style: TextStyle(fontSize: 30),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            maxLines: 10,
            autofocus: true,
            decoration: InputDecoration(
                labelText:
                    "${_months.elementAt(widget.date.month - 1)} ${widget.date.day} was $_feelings because ..",
                labelStyle: Theme.of(context).textTheme.body1,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            controller: _storyEditingController,
          ),
        ),
        Container(
          padding: EdgeInsets.all(25),
          child: RaisedButton(
            onPressed: () {
              _controller.jumpToPage(4);
            },
            child: Text("Done", style: TextStyle(fontSize: 18)),
            elevation: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _fifthPage() {
    return Column(
      children: <Widget>[
        Container(alignment: Alignment.bottomLeft, child: _glowLogo(180)),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            "Awesome - another story locked in, Want to save?",
            style: TextStyle(fontSize: 27),
          ),
        ),
        Spacer(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(25),
          child: RaisedButton.icon(
            onPressed: () {
              _save();
            },
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
              child: Text(isSaving ? "Saving..." : "Save Story".toUpperCase(),
                  style: TextStyle(fontSize: 16)),
            ),
            elevation: 12,
            color: Colors.white,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(25),
          child: GestureDetector(
              onTap: () => _controller.jumpToPage(3),
              child: Text("Wait, I forgot something!".toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white60))),
        ),
        Spacer(),
        Spacer(),
      ],
    );
  }

  Widget _bottomArrows(int back, int after) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white54,
            ),
            onPressed: () {
              if (back == -1)
                Navigator.pop(context);
              else
                _controller.jumpToPage(back);
            },
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
            ),
            onPressed: () {
              _controller.jumpToPage(after);
            },
          ),
        ],
      ),
    );
  }

  Widget _glowLogo(double size) {
    return AvatarGlow(
      endRadius: 90,
      duration: Duration(seconds: 2),
      glowColor: Colors.white24,
      repeat: true,
      repeatPauseDuration: Duration(seconds: 2),
      startDelay: Duration(seconds: 1),
      child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Logo(size: size),
            radius: 40.0,
          )),
    );
  }

  IconData _emoji(double value) {
    if (value < 1) {
      _feelings = "Really terrible";
      return FontAwesomeIcons.tired;
    } else if (value < 2) {
      _feelings = "Somewhat bad";
      return FontAwesomeIcons.frown;
    } else if (value < 3) {
      _feelings = "completely okay";
      return FontAwesomeIcons.smile;
    } else {
      _feelings = "Super awesome";
      return FontAwesomeIcons.grin;
    }
  }

  void _save() async {
    setState(() {
      isSaving = true;
    });
    FirebaseUser user = await UserControl().getCurrentUser();

    Story _story = Story(widget.date, _storyEditingController.text, user.uid,
        _value.floor(), _activity);
    _story.createdAt = DateTime.now();
    _story.updatedAt = DateTime.now();
    _story.favourite = false;
    DocumentReference reference = await StoryController().saveStory(_story);
    setState(() {
      isSaving = false;
    });
    if (reference == null) {
      showDialog(
          context: context,
          builder: (_) {
            return MyAlert(
              title: "Whoops!",
              actions: <Widget>[
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              content: "Something went wrong",
            );
          });
    } else {
      Navigator.pop(context);
    }
  }
}
