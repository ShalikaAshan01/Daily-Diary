import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/pages/my_bottom_navigation_bar.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsAuth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BiometricsAuthState();
}

class _BiometricsAuthState extends State<BiometricsAuth> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authenticated = "Authenticating...";

  Future<bool> _authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "We need authorization to continue",
        // message for dialog
        useErrorDialogs: true,
        // show error in dialog
        stickyAuth: true, // native process
      );
    } catch (e) {
      print(e);
    }
    return authenticated;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authenticateMe().then((val) {
      if (val) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyBottomNavigationBar()));
      }
    });
    return Scaffold(
      backgroundColor: Color(0xFF233355),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child:
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
      ),
    );
  }
}
