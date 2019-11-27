import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/pages/biometrics_auth.dart';
import 'package:daily_diary/pages/my_bottom_navigation_bar.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _biometrics;

  @override
  void initState() {
    super.initState();
    _getBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return _build();
  }

  Widget _build() {
    if (_biometrics == null)
      return Scaffold(
        backgroundColor: Color(0xFF233355),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
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
      );
    else if (_biometrics)
      return BiometricsAuth();
    else
      return MyBottomNavigationBar();
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
}
