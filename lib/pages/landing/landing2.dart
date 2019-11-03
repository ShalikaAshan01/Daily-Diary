import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/pages/landing/landing3.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Landing2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Landing2State();
}

class _Landing2State extends State<Landing2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  Color _nextColor = Colors.white54;

  @override
  Widget build(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;
    CommonWidgets commonWidgets = CommonWidgets();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 25),
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [_accent, _primary],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight)),
        child: Form(
          key: _formKey,
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
                padding: EdgeInsets.fromLTRB(25, 8, 0, 0),
                child: Text(
                  "Let me ask some stuff,",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
                child: Text(
                  "What is your name?",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  validator: (value) {
                    return value.isEmpty ? "Please enter your name" : null;
                  },
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    labelStyle: Theme.of(context).textTheme.body2,
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 26),
                  onChanged: (value) {
                    setState(() {
                      if (value.length > 0) {
                        _nextColor = Colors.white;
                      } else {
                        _nextColor = Colors.white54;
                      }
                    });
                  },
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
                      Navigator.pushReplacementNamed(context, "/landing1");
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: _nextColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              commonWidgets.slideUpNavigation(Landing3(
                                name: _textEditingController.text,
                              )));
                        }
                      });
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
