import 'package:daily_diary/model/story.dart';
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
      body: Stack(
        children: <Widget>[
          _buildFeeling(),
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
                    //todo:create if(showMnu)
                  }),
                  _menuItem(Icons.delete, () {
                    //todo:create if(showMnu)
                  }),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 22, top: 25),
            child: Text(
              "${date.day}, ${_months[date.month - 1]} ${date.year}",
              style: TextStyle(color: Colors.white24, fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, top: 25),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //todo: implement method
                  },
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: _color3,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          FontAwesomeIcons.smile,
                          size: 30,
                          color: Colors.white70,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    //todo: implement method
                  },
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: _color3,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          FontAwesomeIcons.smile,
                          size: 30,
                          color: Colors.white70,
                        ),
                      )),
                ),
              ],
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
      child: _feelingsWidget(widget.story.feeling),
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
      child: Icon(
        icons[val],
        color: Colors.white24,
        size: 100,
      ),
    );
  }
}
