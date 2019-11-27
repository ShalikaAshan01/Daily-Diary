import 'package:daily_diary/controllers/story_controller.dart';
import 'package:daily_diary/pages/about_us.dart';
import 'package:daily_diary/pages/settings/settings.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/name.dart';
import 'package:daily_diary/widgets/user_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfile extends StatelessWidget {
  final Color _color1 = Color(0xFF233355);
  final Color _color3 = Color(0xFF294261);

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    Color secondary = Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: _color1,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: 220,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [primary, secondary]),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(25))),
              child: UserImage(),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 175, top: 180),
              child: Name(
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 250),
              child: Container(
                decoration: BoxDecoration(
                    color: _color3, borderRadius: BorderRadius.circular(15)),
                height: 100,
                child: FutureBuilder(
                  future: StoryController().getCounts(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.data == null)
                      return Row(
                        children: <Widget>[
                          Expanded(
                              child: _rowItem(
                                  icon: FontAwesomeIcons.edit,
                                  text: "Stories",
                                  count: 0)),
                          Expanded(
                              child: _rowItem(
                                  icon: FontAwesomeIcons.heart,
                                  text: "Favourites",
                                  count: 0)),
                        ],
                      );
                    else
                      return Row(
                        children: <Widget>[
                          Expanded(
                              child: _rowItem(
                                  icon: FontAwesomeIcons.edit,
                                  text: "Stories",
                                  count: snapshot.data[0])),
                          Expanded(
                              child: _rowItem(
                                  icon: FontAwesomeIcons.heart,
                                  text: "Favourites",
                                  count: snapshot.data[1])),
                        ],
                      );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 400, left: 20, right: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: <Widget>[
                    _bottomCard(
                        icon: FontAwesomeIcons.solidStar,
                        text: "Rate me 5 stars",
                        left: 0,
                        context: context),
                    _bottomCard(
                        icon: Icons.contact_mail,
                        text: "About us",
                        left: 180,
                        onTap: () =>
                            Navigator.push(context,
                                CommonWidgets().slideUpNavigation(AboutUs())),
                        context: context),
//                    _bottomCard(icon: FontAwesomeIcons.star,text: "About us",left: 360,context: context),
                  ],
                ),
              ),
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
                        context, CommonWidgets().slideUpNavigation(Settings()));
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
          ],
        ),
      ),
    );
  }

  Widget _bottomCard(
      {IconData icon, String text, double left, BuildContext context, onTap}) {
    Color primary = Theme.of(context).primaryColor;
    Color secondary = Theme.of(context).accentColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: left),
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primary, secondary]),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Icon(
                icon,
                color: Colors.white70,
                size: 20,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 150),
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }

  Widget _rowItem({IconData icon, String text, int count}) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(count.toString())),
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30),
              child: Text(text)),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: Colors.white12,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
