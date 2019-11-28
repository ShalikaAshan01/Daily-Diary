import 'package:avatar_glow/avatar_glow.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:daily_diary/controllers/story_controller.dart';
import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/model/story.dart';
import 'package:daily_diary/pages/story/add_stories.dart';
import 'package:daily_diary/pages/story/show_story.dart';
import 'package:daily_diary/pages/story/show_story_without.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/logo.dart';
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
  var _formatter = DateFormat('yyyy-MM-dd');
  Color _color1 = Color(0xFF233355);
  String _userId = "";
  bool _loading = true;
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
  var _formatter2 = DateFormat('MMM dd');
  double _monthlyRate = 0;
  double _weeklyRate = 0;
  List<Rate> _weeklyRates = List();
  List<Rate> _monthlyRates = List();
  List<Rate> _weeklyPie = List();
  List<Rate> _monthlyPie = List();
  static bool _weekly = true;

  _getStories() {
    StoryController().getStoriesAsList().then((List<Story> story) {
      List<String> dateTime = List();
      for (int i = 0; i < story.length; i++) {
        dateTime.add(_formatter.format(story[i].date));
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
          _userId = user.uid;
        });
    });
    _pageController();
    _setChartValues();
  }

  @override
  Widget build(BuildContext context) {
    int length = -1;
    if (_stories != null) {
      length = _stories.length;
    }
    _getStories();
    return Scaffold(
      backgroundColor: _color1,
      body: length != 0 ?
      _body() : Center(child: Text(
        "Looks like you don't have any stories", style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,),),
    );
  }

  Widget _body() {
    if (_loading)
      return Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AvatarGlow(
              endRadius: 90,
              duration: Duration(milliseconds: 500),
              glowColor: Colors.white24,
              repeat: true,
              repeatPauseDuration: Duration(seconds: 2),
              startDelay: Duration(seconds: 1),
              child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Logo(size: 140),
                    radius: 40.0,
                  )),
            ),
            Text(
              "please give me a moment to collect my thoughts...".toUpperCase(),
              textAlign: TextAlign.center,)
          ],
        ),
      );
    else
      return ListView(
        children: <Widget>[
          _chartBuild(context),
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
          Container(height: 600, child: _favouriteBuilder()),
        ],
      );
  }

  void _setChartValues() async {
    List<int> feelings = await StoryController().getRate();
    List<Rate> tempWeeklyRate = List();
    List<Rate> tempMonthlyRate = List();
    int tempMonth = 0;
    int tempWeek = 0;
    for (int i = 0; i < feelings.length - 1; i++) {
      tempMonth += feelings[i];
      tempMonthlyRate.add(Rate(i + 1, feelings[i]));
      if (i < 7) {
        tempWeek += feelings[i];
        tempWeeklyRate.add(Rate(i + 1, feelings[i]));
      }
    }

    List<int> activity = await StoryController().getActivityCount(7);
    List<int> activity1 = await StoryController().getActivityCount(31);

    List<Rate> tempPei = List();
    List<Rate> tempPei2 = List();

    for (int i = 0; i < activity.length; i++) {
      tempPei.add(Rate(i, activity[i]));
    }
    for (int i = 0; i < activity1.length; i++) {
      tempPei2.add(Rate(i, activity1[i]));
    }
    if (mounted)
      setState(() {
        _weeklyRates = tempWeeklyRate;
        _monthlyRates = tempMonthlyRate;
        _weeklyPie = tempPei;
        _monthlyPie = tempPei2;
        _monthlyRate = tempMonth / 31.0;
        _weeklyRate = tempWeek / 7.0;
        _loading = false;
      });
  }

  Widget _chartBuild(BuildContext context) {
    Color primary = Theme
        .of(context)
        .primaryColor;
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
                borderRadius: BorderRadius.circular(25)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(25)),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _weekly = true;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                _weekly ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.all(8.0),
                            width: 100,
                            child: Text(
                              "weekly",
                              style: TextStyle(
                                  color: _weekly ? primary : Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _weekly = false;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                !_weekly ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.all(8.0),
                            width: 100,
                            child: Text(
                              "monthly",
                              style: TextStyle(
                                  color: !_weekly ? primary : Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12, left: 15),
                  child: Text(
                    _weekly ? "This Week" : "This Month",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12, left: 15),
                  child: Text(
                    _weekly
                        ? "${_formatter2.format(DateTime.now())} - ${_formatter2
                        .format(DateTime.now().subtract(Duration(days: 7)))}"
                        : "${_formatter2.format(DateTime.now())} - ${_formatter2
                        .format(DateTime.now().subtract(Duration(days: 31)))}",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12, left: 15),
                  child: Text(_weekly
                      ? "${_weeklyRate.toStringAsFixed(2)} %"
                      : "${_monthlyRate.toStringAsFixed(2)} %",
                    style: TextStyle(fontSize: 25),),),
                Container(
                  padding: EdgeInsets.only(top: 12, left: 15),
                  child: Text(
                    _weekly
                        ? "Your  weekly Rating".toUpperCase()
                        : "Your monthly rating".toUpperCase(),
                    style: TextStyle(fontSize: 13, color: Colors.white38),
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 200.0,
                    child: _rateChart(),
                  ),
                ),
                SizedBox(height: 150,)
              ],
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              decoration: BoxDecoration(
                  color: _color1,
                  borderRadius: BorderRadius.circular(25)
              ),
              margin: EdgeInsets.only(top: 390),
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 200.0,
                child: _pieCart(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rateChart() {
    var series1 = [
      charts.Series<Rate, int>(
        id: "weekly_rate",
        colorFn: (_, __) => charts.MaterialPalette.white,
        domainFn: (Rate rate, _) => rate.day,
        measureFn: (Rate rate, _) => rate.rate,
        data: _weeklyRates,
      )
    ];
    var series2 = [
      charts.Series<Rate, int>(
        id: "monthly_rate",
        colorFn: (_, __) => charts.MaterialPalette.white,
        domainFn: (Rate rate, _) => rate.day,
        measureFn: (Rate rate, _) => rate.rate,
        data: _monthlyRates,
      )
    ];
    var viewport1 = charts.NumericExtents(1.0, 7.0);
    var viewport2 = charts.NumericExtents(1.0, 30.0);

    var chart = charts.LineChart(
      _weekly ? series1 : series2,
      animate: true,
      domainAxis: charts.NumericAxisSpec(
        viewport: _weekly ? viewport1 : viewport2,
        renderSpec: charts.GridlineRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.transparent,
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.transparent,
          ),
          labelStyle: charts.TextStyleSpec(
              fontSize: 10, color: charts.MaterialPalette.transparent),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                  fontSize: 10, color: charts.MaterialPalette.transparent),
              lineStyle: charts.LineStyleSpec(
                  thickness: 0, color: charts.MaterialPalette.transparent))),
      behaviors: [charts.PanAndZoomBehavior()],
    );
    return chart;
  }

  Widget _pieCart() {
    List<String> act = [
      "work",
      "family",
      "education",
      "relationship",
      "friends",
      "traveling",
      "gaming",
      "sports",
      "other"
    ];
    var pie = [
      charts.Series<Rate, int>(
        id: 'pie',
        domainFn: (Rate rate, _) => rate.day,
        measureFn: (Rate rate, _) => rate.rate,
        data: _weekly ? _weeklyPie : _monthlyPie,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (Rate row, _) => '${act[row.day].toUpperCase()}',
      )
    ];
    return charts.PieChart(pie,
        animate: false,
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  Widget _customCalender(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayLongPressed: (DateTime date) {},
        onDayPressed: (DateTime date, List<Event> events) {
          if (_dates != null) {
            int index = _dates.indexOf(_formatter.format(date));
            if (index != -1) {
              Navigator.push(
                  context,
                  CommonWidgets().slideUpNavigation(ShowStoryWithout(
                    story: _stories[index],
                  )));
            } else if (_formatter.format(date) ==
                _formatter.format(DateTime.now())) {
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
            if (_dates.contains(_formatter.format(day))) {
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
      stream: StoryController().getFavourites(_userId),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.white54,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(child: Text("Whoops!, There are no favourite stories",
                  textAlign: TextAlign.center,)),
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

class Rate {
  final int day;
  final int rate;

  Rate(this.day, this.rate);
}
