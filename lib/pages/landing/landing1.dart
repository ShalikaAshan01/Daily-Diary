import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/delayed_animation.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'landing2.dart';

class Landing1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Landing1State();
}

class _Landing1State extends State<Landing1>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  final CommonWidgets commonWidgets = CommonWidgets();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Theme.of(context).accentColor,
        Theme.of(context).primaryColor
      ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
      child: Column(
        children: <Widget>[
          AvatarGlow(
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
                  child: Logo(size: 180),
                  radius: 50.0,
                )),
          ),
          DelayedAnimation(
            child: Text(
              "Hi There",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
            ),
            delay: delayedAmount + 1000,
          ),
          DelayedAnimation(
            child: Text(
              "I'm Daily Diary",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
            ),
            delay: delayedAmount + 2000,
          ),
          SizedBox(
            height: 30.0,
          ),
          DelayedAnimation(
            child: Text(
              "Your New Personal",
              style: TextStyle(fontSize: 20.0, color: Colors.white70),
            ),
            delay: delayedAmount + 3000,
          ),
          DelayedAnimation(
            child: Text(
              "Journaling  companion",
              style: TextStyle(fontSize: 20.0, color: Colors.white70),
            ),
            delay: delayedAmount + 3000,
          ),
          SizedBox(
            height: 100.0,
          ),
          DelayedAnimation(
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTap: () {
                Navigator.pushReplacement(
                    context, commonWidgets.slideUpNavigation(Landing2()));
              },
              child: Transform.scale(
                scale: _scale,
                child: _animatedButtonUI,
              ),
            ),
            delay: delayedAmount + 4000,
          ),
          SizedBox(
            height: 50.0,
          ),
          DelayedAnimation(
            child: Text(
              "I Already have An Account".toUpperCase(),
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold, color: color),
            ),
            delay: delayedAmount + 5000,
          ),
        ],
      ),
    )
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
        //     SizedBox(
        //       height: 20.0,
        //     ),
        //      Center(

        //   ),
        //   ],

        // ),
        );

//    return Scaffold(
//      body: Container(
//        child: Stack(
//          children: <Widget>[
//            wave(),
//             Container(
//               padding: const EdgeInsets.fromLTRB(15,0,15,0),
//                child: Stack(
//                  children: <Widget>[
//                    wave(),
//                    Container(
//                        alignment: Alignment.topCenter,
//                        padding: EdgeInsets.only(top: 100),
//                        child: Column(
//                          children: <Widget>[
//                            FadeTransition(
//
//                                child: Text(
//                              "Hi! There,",
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: 40,
//                                  fontWeight: FontWeight.bold),
//                            ), opacity: animation1,),
//                            FadeTransition(
//                              opacity: animation2,
//                              child: Text(
//                                "Welcome to Daily Diary",
//                                style: TextStyle(color: Colors.white, fontSize: 25),
//                              ),
//                            ),
//                          ],
//                        )),
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(30, 400, 30, 0),
//                      child: ListView(
//                        children: <Widget>[
//                          Container(
//                            child: FadeTransition(
//                              opacity: animation3,
//                              child: RaisedButton(
//                                elevation: 10,
//                                onPressed: () {
//
//                                  Navigator.pushReplacement(context, commonWidgets.slideUpNavigation(Landing2()));
//                                },
//                                child: Text(
//                                  "I'm new here",
//                                  style: Theme.of(context).textTheme.body1,
//                                ),
//                              ),
//                            ),
//                          ),
//                          SizedBox(
//                            height: 25,
//                          ),
//                          Container(
//                            child: FadeTransition(
//                              opacity: animation4,
//                              child: RaisedButton(
//                                elevation: 5,
//                                color: Colors.white,
//                                onPressed: () {},
//                                child: Text(
//                                  "I already have an Account",
//                                  style: Theme.of(context).textTheme.body2,
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//          ],
//        ),
//      ),
//    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'I\'m new here',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
