import 'package:daily_diary/controllers/story_controller.dart';
import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/model/story.dart';
import 'package:daily_diary/pages/settings/settings.dart';
import 'package:daily_diary/pages/story/add_stories.dart';
import 'package:daily_diary/pages/story/show_story.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/delayed_animation.dart';
import 'package:daily_diary/widgets/name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  PageController _ctrl;
  int _currentPage = 0;
  String _text = "Good Morning";
  String _addText = "Add today's story";
  Image _image = Image.asset(
    "assets/imgs/sunrise.png",
    width: 55,
    height: 55,
    color: Colors.white30,
  );
  DateTime _addStoryDate;
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

  final int delayedAmount = 100;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  String userId;

  @override
  void initState() {
    super.initState();
    _addStoryDate = DateTime.now();
    _pageController();
    _animationControl();
    _offsetFloat = Tween<Offset>(begin: Offset(0.25, 0.0), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
    UserControl().getCurrentUser().then((FirebaseUser user) {
      if (mounted)
        setState(() {
          userId = user.uid;
        });
    });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _greeting();
    return _mainPage();
  }

  Widget _mainPage() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: CustomPaint(
            painter: _Background(),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.08, left: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DelayedAnimation(
                          delay: delayedAmount,
                          child: Text(
                            _text,
                            style: TextStyle(
                                fontSize: 25, color: Colors.white60),
                          )),
                      SizedBox(
                        height: 13,
                      ),
                      DelayedAnimation(
                          delay: delayedAmount + 1000,
                          child: Name(
                            textStyle:
                            TextStyle(fontSize: 25, color: Colors.white30),
                          )),
                    ],
                  ),
                ),
                SlideTransition(
                  position: _offsetFloat,
                  child: StreamBuilder(
                      stream: StoryController().getStories(userId),
                      builder: (context, snapshot) {
                        List stories;
                        int length;
                        if (snapshot.hasData) {
                          stories = snapshot.data.documents;
                          length = stories.length;
                        } else {
                          length = 0;
                        }
                        return PageView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _ctrl,
                          itemCount: length != 0 ? length + 2 : length + 1,
                          onPageChanged: (value) {
                            setState(() {
                              _currentPage = value;
                            });
                          },
                          itemBuilder: (context, int currentIdx) {
                            bool active = currentIdx == _currentPage;

                            if (currentIdx == 0) {
                              return _firstPage(active);
                            }
                            if (length != 0 && currentIdx == length + 1) {
                              return Container(
                              );
                            }

                            Story story =
                            Story.fromMapObject(stories[currentIdx - 1].data);
                            story.id = stories[currentIdx - 1].reference
                                .documentID;

                            if (_addStoryDate
                                .difference(story.date)
                                .inDays == 0) {
                              DateTime newDate =
                              story.date.subtract(Duration(days: 1));
                              _addStoryDate = newDate;
                              _addText =
                              "add ${_months[newDate.month - 1].substring(
                                  0, 3)} ${newDate.day}'s story";
                            }
                            return _customCards(story, active);
                          },
                        );
                      }),
                ),
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.fromLTRB(0, 45, 0, 10),
                  height: 120,
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CommonWidgets().slideUpNavigation(Settings()));
                      },
                      child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(right: 40, left: 20),
                          width: 65,
                          height: 45,
                          child: Icon(
                            FontAwesomeIcons.slidersH,
                            color: Colors.white,
                            size: 27,
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, top: size.height * 0.08),
                  child: _image,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _firstPage(bool active) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;

    final double top = active ? 150 : 200;
    final double bottom = active ? 80 : 50;
    final double offset = active ? 20 : 0;
    final double blur = active ? 30 : 0;

    double radius = 25;

    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        margin: EdgeInsets.only(left: 10, right: 10),
        padding: EdgeInsets.fromLTRB(10, top, 10, bottom),
        child: GestureDetector(
          onTap: () {
            if (_text != "Good Morning") {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) =>
                      AddStories(
                        greeting: _text,
                        date: _addStoryDate,
                      ),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 800),
                ),
              );
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [_primary, _accent],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        blurRadius: blur,
                        offset: Offset(offset, offset))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.edit,
                    color: Colors.white30,
                    size: 45,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _addText.toUpperCase(),
                    style: TextStyle(color: Colors.white30),
                  )
                ],
              )),
        ));
  }

  Widget _customCards(Story _story, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 150 : 200;
    final double bottom = active ? 80 : 50;
    final DateTime storyDate = _story.date;
    final int _date = storyDate.day;
    final String _month = _months[storyDate.month - 1].substring(0, 3);
    final int _year = storyDate.year;

    return Hero(
      tag: _story.id,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ShowStory(
                        story: _story,
                      )));
        },
        onDoubleTap: () {
          StoryController().updateFavouriteItem(!_story.favourite, _story.id);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            margin:
            EdgeInsets.only(top: top, bottom: bottom, right: 20, left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_story.image),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: blur,
                      offset: Offset(offset, offset))
                ]),
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Stack(
                children: <Widget>[
                  _feelingsWidget(_story.feeling),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "$_date",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                child: Text("$_month"),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 35),
                                child: Text(
                                  "$_year",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            _story.favourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: _story.favourite
                              ? Colors.redAccent
                              : Colors.white54,
                          splashColor: Colors.redAccent,
                          onPressed: () {
                            StoryController().updateFavouriteItem(
                                !_story.favourite, _story.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _feelingsWidget(int val) {
    List<IconData> icons = [
      FontAwesomeIcons.tired,
      FontAwesomeIcons.frown,
      FontAwesomeIcons.smile,
      FontAwesomeIcons.grin
    ];
    if (val == 4) val = 3;
    return Container(
      padding: EdgeInsets.only(bottom: 5, right: 5),
      alignment: Alignment.bottomRight,
      child: Icon(
        icons[val],
        color: Colors.white38,
        size: 120,
      ),
    );
  }

  void _pageController() {
    _ctrl = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8,
    )
      ..addListener(() {
        setState(() {});
      });
  }

  void _animationControl() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 1,
        ))
      ..addListener(() {
        if (mounted) setState(() {});
      });
  }

  void _greeting() {
    int hour = DateTime.now().hour;
    if (mounted) if (hour > 2 && hour < 12) {
      setState(() {
        _text = "Good morning,";
        _image = Image.asset(
          "assets/imgs/sunrise.png",
          width: 55,
          height: 55,
          color: Colors.white30,
        );
      });
    } else if (hour < 17) {
      setState(() {
        _text = "Good afternoon,";
        _image = Image.asset(
          "assets/imgs/sun.png",
          width: 55,
          height: 55,
          color: Colors.white30,
        );
      });
    } else if (hour < 20) {
      setState(() {
        _text = "Good evening,";
        _image = Image.asset(
          "assets/imgs/sun_cloud.png",
          width: 55,
          height: 55,
          color: Colors.white30,
        );
      });
    } else {
      setState(() {
        _text = "Good night,";
        _image = Image.asset(
          "assets/imgs/moon.png",
          width: 55,
          height: 55,
          color: Colors.white30,
        );
      });
    }
  }
}

class _Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Color _color1 = Color(0xFF233355);
    Color _color2 = Color(0xFF29395A);
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width * 0.75, size.height);
    path.lineTo(0, size.height);
    paint.color = _color1;
    canvas.drawPath(path, paint);

    path = Path();
    path.moveTo(size.width * 0.75, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.75, size.height);
    paint.color = _color2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
