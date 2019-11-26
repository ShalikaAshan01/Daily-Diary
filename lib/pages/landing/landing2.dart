import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/pages/landing/landing3.dart';
import 'package:daily_diary/pages/privacy_policy.dart';
import 'package:daily_diary/utils/auth.dart';
import 'package:daily_diary/widgets/common_widgets.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Landing2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Landing2State();
}

class _Landing2State extends State<Landing2>
    with SingleTickerProviderStateMixin {
  Color _nextColor = Colors.white54;
  IconData _fbIcon = FontAwesomeIcons.facebookF;
  CommonWidgets commonWidgets = CommonWidgets();
  bool isLoading = false;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              isLoading ?
              LinearProgressIndicator(value: animation.value,) : Container(),
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
                  !isLoading?"Account Login":"Please wait...",
                  style: TextStyle(
                      fontSize: 54,
                      color: Colors.white30,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                child: RaisedButton.icon(
                  onPressed: () async {
                    if(!isLoading){
                      await _googleSignIn();
                    }
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      width: 25,
                      image: AssetImage("assets/imgs/google.png"),
                    )
                    ,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.only(top:20.0,bottom: 20),
                    child: Text("Sign in with Google",
                      style: TextStyle(fontSize: 18, color: Colors.grey),),
                  ),
                  color: Colors.white,
                  elevation: 10,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                child: RaisedButton.icon(
                  onPressed: () async{
                    if(!isLoading){
                      await _facebookSignIn();
                    }
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(_fbIcon, size: 22,),
                  ),
                  label: Padding(
                    padding: const EdgeInsets.only(top:20.0,bottom: 20),
                    child: Text(
                      "Sign in with Facebook", style: TextStyle(fontSize: 18),),
                  ),
                  color: Color(0xFF4267b2),
                  elevation: 10,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.push(context,
                            CommonWidgets().slideUpNavigation(PrivacyPolicy())),
                    child: Text(
                        "By clicking the above buttons, you agree to the our terms and conditions"),
                  )),
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
                    onPressed: () {},
                  ),
                ],
              ))
            ],
          ),
      ),
    );
  }

  Future<void> _googleSignIn() async{
    setIsLoading(true);
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    AuthCredential authCredential = await getSignedInGoogleAccount(googleSignIn);
    FirebaseUser user = await signIn(authCredential);
    UserControl userControl = UserControl();
    String name = await userControl.getName();
    setIsLoading(false);
    if(user!=null){
      Navigator.pushReplacement(
          context, commonWidgets.slideUpNavigation(Landing3(name: name,)));
    }
  }

  Future<void> _facebookSignIn()async{
    setIsLoading(true);
    AuthCredential authCredential = await getSignedInFacebook();
    FirebaseUser user = await signIn(authCredential);
    UserControl userControl = UserControl();
    String name = await userControl.getName();
    setIsLoading(false);
    if(user!=null){
      Navigator.pushReplacement(
          context, commonWidgets.slideUpNavigation(Landing3(name: name,)));
    }
  }
  setIsLoading(bool value){
    setState(() {
      isLoading = value;
    });
  }
}
