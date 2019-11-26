import 'package:daily_diary/controllers/story_controller.dart';
import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/model/story.dart';
import 'package:daily_diary/pages/story/add_stories.dart';
import 'package:daily_diary/pages/story/show_story.dart';
import 'package:daily_diary/pages/story/show_story_without.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TasksTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TaskTabState();
}

class _TaskTabState extends State<TasksTab> {
  List<Story> _stories;
  List<String> _dates;
  var formatter = DateFormat('yyyy-MM-dd');
  Color _color1 = Color(0xFF233355);
  String userId = "";
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
  PageController _ctrl;
  int _currentPage = 0;

  getStories() {
    StoryController().getStoriesAsList().then((List<Story> story) {
      List<String> dateTime = List();
      for (int i = 0; i < story.length; i++) {
        dateTime.add(formatter.format(story[i].date));
      }
      if (mounted)
        setState(() {
          _dates = dateTime;
          _stories = story;
        });
    });
  }

  @override
  void initState() {
    super.initState();
    UserControl().getCurrentUser().then((FirebaseUser user) {
      if (mounted)
        setState(() {
          userId = user.uid;
        });
    });
    _pageController();
  }


  @override
  Widget build(BuildContext context) {
    getStories();
    return Scaffold(
      backgroundColor: _color1,
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, top: 25),
            child: Text(
              "Stories",
              style: TextStyle(fontSize: 20),
            ),
          ),
          _customCalender(context),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Favourite",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(height: 600, child: _favouriteBuilder())
        ],
      ),
    );
  }

  Widget _customCalender(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayLongPressed: (DateTime date) {},
        onDayPressed: (DateTime date, List<Event> events) {
          if (_dates != null) {
            int index = _dates.indexOf(formatter.format(date));
            if (index != -1) {
              Navigator.push(
                  context,
                  CommonWidgets().slideUpNavigation(ShowStoryWithout(
                    story: _stories[index],
                  )));
            } else
            if (formatter.format(date) == formatter.format(DateTime.now())) {
              print("gsegesg");
            } else if (date.isBefore(DateTime.now())) {
              Navigator.push(
                  context,
                  CommonWidgets().slideUpNavigation(AddStories(
                    greeting: "${_months[date.month - 1]} ${date.day}",
                    date: date,
                  )));
            }
          }
        },
        weekendTextStyle: TextStyle(
          color: _primary,
        ),
        thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        customDayBuilder: (

            /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          if (_dates != null) {
            if (_dates.contains(formatter.format(day))) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      day.day.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 15,
                    ),
                  ],
                ),
              );
            } else {
              return null;
            }
          } else {
            return null;
          }
        },
        selectedDayButtonColor: _primary,
        daysTextStyle: TextStyle(color: Colors.white),
        weekFormat: false,
//        markedDatesMap: _markedDateMap,
        height: 450.0,
//        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  Widget _favouriteBuilder() {
    return StreamBuilder(
      stream: StoryController().getFavourites(userId),
      builder: (context, snapshot) {
        int length = 0;
        List stories;
        if (snapshot.hasData) {
          stories = snapshot.data.documents;
          length = stories.length;
        } else {
          length = 0;
        }

        if (length == 0) {
          return Container(
            margin: EdgeInsets.fromLTRB(60, 50, 60, 80),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: 30,
                      offset: Offset(20, 20))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.white54,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Whoops!, There are no favourite stories"),
                Spacer(),
              ],
            ),
          );
        }

        return PageView.builder(
          controller: _ctrl,
          itemCount: length,
          onPageChanged: (value) {
            if (mounted)
              setState(() {
                _currentPage = value;
              });
          },
          itemBuilder: (context, int currentIdx) {
            bool active = currentIdx == _currentPage;
            Story story = Story.fromMapObject(stories[currentIdx].data);
            story.id = stories[currentIdx].reference.documentID;
            return _customCards(story, active);
          },
        );
      },
    );
  }

  Widget _customCards(Story _story, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 0 : 50;
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
                  builder: (context) => ShowStory(
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
    );
  }
}
