import 'package:daily_diary/pages/home.dart';
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
    //todo:add style
    _authenticateMe().then((val) {
      if (val) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
    return Scaffold(
      backgroundColor: Color(0xFF233355),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(_authenticated),
      ),
    );
  }
}
