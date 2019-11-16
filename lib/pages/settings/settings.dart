import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/themes/custom_theme.dart';
import 'package:daily_diary/themes/my_themes.dart';
import 'package:daily_diary/utils/my_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color _color1 = Color(0xFF233355);
  Color _color2 = Color(0xFF29395A);
  Color _color3 = Color(0xFF294261);
  String name;
  bool _biometrics = false;
  bool _notification = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _hasFingerPrintSupport = false;
  TextEditingController _nameEditingController = TextEditingController();
  int themeKey = 0;
  String photoUrl;

  @override
  void initState() {
    super.initState();
    name = "";
    UserControl().getName().then((String _name) {
      setState(() {
        name = _name;
      });
    });
    UserControl().getCurrentUser().then((FirebaseUser user) {
      setState(() {
        photoUrl = user.photoUrl;
      });
    });
    _getBiometrics();
    _getBiometricsSupport();
    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color1,
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.only(top: 35),
                  child: Container(
                    decoration: BoxDecoration(
                        color: _color3,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    width: 85,
                    height: 45,
                    child: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Theme
                              .of(context)
                              .primaryColor,
                          Theme
                              .of(context)
                              .accentColor,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                      )),
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.only(right: 30),
                  child: photoUrl == null ? Icon(
                    FontAwesomeIcons.camera,
                    color: Colors.white60,
                    size: 50,
                  ) :
                  Image(image: NetworkImage(photoUrl),)
                  ,
                ),
              ),
              _customNameCard(),
              Container(
                margin: EdgeInsets.only(top: 160),
                child: _customCardToggle(
                    height: 150,
                    icon: FontAwesomeIcons.fingerprint,
                    title: _biometrics ? "Enabled" : "Disabled",
                    subtitle: "biometric passcode".toUpperCase(),
                    value: _biometrics,
                    onChanged: (_) async {
                      await _setBiometrics();
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 320),
                child: _customCardToggle(
                    height: 150,
                    icon: FontAwesomeIcons.bell,
                    title: _notification ? "Enabled" : "Disabled",
                    subtitle: "Notifications".toUpperCase(),
                    value: _notification,
                    onChanged: (_) async {
                      await _setNotifications();
                    }
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 130,
                margin: EdgeInsets.only(top: 715),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme
                                .of(context)
                                .primaryColor,
                            Theme
                                .of(context)
                                .accentColor,
                          ]
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(10),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _themeButton(
                              onTap: () {
                                setState(() {
                                  CustomTheme.instanceOf(context)
                                      .changeTheme(MyThemeKeys.Theme1);
                                });
                              },
                              themeData: MyThemes.theme1
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _themeButton(
                              onTap: () {
                                setState(() {
                                  CustomTheme.instanceOf(context)
                                      .changeTheme(MyThemeKeys.Theme2);
                                });
                              },
                              themeData: MyThemes.theme2
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _themeButton(
                              onTap: () {
                                setState(() {
                                  CustomTheme.instanceOf(context)
                                      .changeTheme(MyThemeKeys.Theme3);
                                });
                              },
                              themeData: MyThemes.theme3
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _themeButton(
                              onTap: () {
                                setState(() {
                                  CustomTheme.instanceOf(context)
                                      .changeTheme(MyThemeKeys.Theme4);
                                });
                              },
                              themeData: MyThemes.theme4
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _themeButton(
                              onTap: () {
                                setState(() {
                                  CustomTheme.instanceOf(context)
                                      .changeTheme(MyThemeKeys.Theme5);
                                });
                              },
                              themeData: MyThemes.theme5
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _themeButton(
                              onTap: () {
                                setState(() {
                                  CustomTheme.instanceOf(context)
                                      .changeTheme(MyThemeKeys.Theme6);
                                });
                              },
                              themeData: MyThemes.theme6
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 855, bottom: 20),
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () async {
                    await UserControl().logout();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacementNamed(context, "/landing1");
                  },
                  child: Text("LOGOUT", style: Theme
                      .of(context)
                      .textTheme
                      .body1,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changeName(String name) async {
    await UserControl().updateUserName(name);
  }

  Future<void> _getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool notification = prefs.getBool("reminder");
    setState(() {
      _notification = notification;
    });
  }

  Future<void> _setNotifications() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (_notification) {
      await preferences.setBool("reminder", true);
      await MyNotifications().dailyNotification();
    } else {
      await preferences.setBool("reminder", false);
      await MyNotifications().cancelNotifications();
    }
  }

  Future<void> _getBiometrics() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool bio = preferences.getBool("biometrics");
    if (bio == null) {
      preferences.setBool("biometrics", false);
      bio = false;
    }
    setState(() {
      _biometrics = bio;
    });
  }

  Future<void> _setBiometrics() async {
    if (_hasFingerPrintSupport) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool("biometrics", !_biometrics);
      setState(() {
        _biometrics = !_biometrics;
      });
    } else
      setState(() {
        _biometrics = false;
      });
  }

  Future<void> _getBiometricsSupport() async {
    // 6. this method checks whether your device has biometric support or not
    bool hasFingerPrintSupport = false;
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrintSupport = hasFingerPrintSupport;
    });
  }

  Widget _customNameCard() {
    return Container(
      margin: EdgeInsets.only(top: 230, left: 10, right: 10),
      height: 150,
      width: double.infinity,
      child: Card(
        color: _color2,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Icon(
                FontAwesomeIcons.user,
                size: 90,
                color: Colors.white24,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: TextField(
                  cursorWidth: 0,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                  decoration: InputDecoration.collapsed(
                      hintText: name,
                      hintStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      )),
                  onTap: () {
                    _nameEditingController.text = name;
                  },
                  textInputAction: TextInputAction.done,
                  controller: _nameEditingController,
                  onSubmitted: (value) async {
                    setState(() {
                      name = value;
                      _nameEditingController.text = value;
                    });
                    await _changeName(value);
                  },
                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Text(
                  "Your nick name".toUpperCase(),
                  style: TextStyle(color: Colors.white38),
                )),
          ],
        ),
      ),
    );
  }

  Widget _customCardToggle(
      {@required double height,
      @required IconData icon,
      @required String title,
      @required String subtitle,
        @required Function onChanged,
        @required bool value,
      bool isName}) {
    return Container(
      margin: EdgeInsets.only(top: 230, left: 10, right: 10),
      height: height,
      width: double.infinity,
      child: Card(
        color: _color2,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Icon(
                icon,
                size: 90,
                color: Colors.white24,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.white38),
                )),
            Container(
              width: double.infinity,
              height: height,
              padding: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              child: Transform.scale(
                scale: 1.5,
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            )
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
        width: 65,
        height: 65,
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
