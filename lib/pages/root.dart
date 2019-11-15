import 'package:daily_diary/pages/biometrics_auth.dart';
import 'package:daily_diary/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class root extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootState();
}

class _RootState extends State<root> {
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
      //todo:add loading
      return Scaffold();
    if (_biometrics) return BiometricsAuth();
    if (!_biometrics) return Home();
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
