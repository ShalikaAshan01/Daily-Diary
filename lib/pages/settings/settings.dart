import 'package:daily_diary/controllers/user_control.dart';
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
  bool biometrics = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _hasFingerPrintSupport = false;
  TextEditingController _nameEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = "";
    UserControl().getName().then((String _name) {
      setState(() {
        name = _name;
      });
    });
    _getBiometrics();
    _getBiometricsSupport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color1,
      body: SingleChildScrollView(
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
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                    )),
                width: 150,
                height: 150,
                margin: EdgeInsets.only(right: 30),
                child: Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.white60,
                  size: 50,
                ),
              ),
            ),
            _customNameCard(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 160),
              child: _customCardToggle(
                  height: 150,
                  icon: FontAwesomeIcons.fingerprint,
                  title: biometrics ? "Enabled" : "Disabled",
                  subtitle: "biometric passcode".toUpperCase()),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _changeName(String name) async {
    await UserControl().updateUserName(name);
  }

  Future<void> _getBiometrics() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool bio = preferences.getBool("biometrics");
    if (bio == null) {
      preferences.setBool("biometrics", false);
      bio = false;
    }
    setState(() {
      biometrics = bio;
    });
  }

  Future<void> _setBiometrics() async {
    if (_hasFingerPrintSupport) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool("biometrics", !biometrics);
      setState(() {
        biometrics = !biometrics;
      });
    } else
      setState(() {
        biometrics = false;
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
                  value: biometrics,
                  onChanged: (_) async {
                    await _setBiometrics();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
