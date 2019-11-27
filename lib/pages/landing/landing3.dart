import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/pages/landing/landing4.dart';
import 'package:daily_diary/themes/custom_theme.dart';
import 'package:daily_diary/themes/my_themes.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Landing3 extends StatefulWidget {
  final String name;

  const Landing3({Key key, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Landing3State(name);
}

class _Landing3State extends State<Landing3> {
  final name;

  _Landing3State(this.name);

  @override
  Widget build(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.only(top: 25),
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
              padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
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
              padding: EdgeInsets.fromLTRB(25, 8, 0, 0),
              child: Text(
                "Hello! $name",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
              child: Text(
                "Magical Color Change:)",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: _themeButton(
                        themeData: MyThemes.theme6,
                        onTap: () {
                          setState(() {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemeKeys.Theme6);
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: _themeButton(
                        themeData: MyThemes.theme5,
                        onTap: () {
                          setState(() {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemeKeys.Theme5);
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: _themeButton(
                        themeData: MyThemes.theme4,
                        onTap: () {
                          setState(() {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemeKeys.Theme4);
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: _themeButton(
                        themeData: MyThemes.theme3,
                        onTap: () {
                          setState(() {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemeKeys.Theme3);
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: _themeButton(
                        themeData: MyThemes.theme2,
                        onTap: () {
                          setState(() {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemeKeys.Theme2);
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: _themeButton(
                        themeData: MyThemes.theme1,
                        onTap: () {
                          setState(() {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemeKeys.Theme1);
                          });
                        }),
                  ),
                ],
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
                  onPressed: () {},
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    CommonWidgets commonWidgets = CommonWidgets();
                    Navigator.push(
                        context, commonWidgets.slideUpNavigation(Landing4()));
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _themeButton({ThemeData themeData, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8.0,
                  offset: Offset(0.0, 1.0),
                  spreadRadius: 2),
            ]),
        width: 80,
        height: 80,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [themeData.primaryColor, themeData.accentColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              )),
        ),
      ),
    );
  }
}
