import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/pages/home.dart';
import 'package:daily_diary/utils/my_notifications.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Landing4State();
}

class _Landing4State extends State<Landing4> {
  @override
  Widget build(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;

    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [_primary, _accent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: AvatarGlow(
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
                      child: Logo(size: 140),
                      radius: 40.0,
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 25, right: 25),
              child: Text(
                "last thing: want me to send you reminders?",
                style: TextStyle(fontSize: 28),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(left: 35, right: 35),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  CommonWidgets commonWidgets = CommonWidgets();
                  MyNotifications myNotification = MyNotifications();
                  myNotification.initialize();
                  myNotification
                      .displayNotification("Hey,Welcome to Daily Diary");
                  await myNotification.dailyNotification();
                  await saveReminder(true);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context, commonWidgets.slideUpNavigation(Home()));
                },
                elevation: 20,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Yes, Please".toUpperCase(),
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 25),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    CommonWidgets commonWidgets = CommonWidgets();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    saveReminder(false).then((_) => Navigator.pushReplacement(
                        context, commonWidgets.slideUpNavigation(Home())));
                  });
                },
                child: Center(
                  child: Text(
                    "No. Thanks".toUpperCase(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
                child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Future<bool> saveReminder(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool("reminder", value);
  }
}
