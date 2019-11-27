import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/pages/landing/landing1.dart';
import 'package:daily_diary/pages/landing/landing2.dart';
import 'package:daily_diary/pages/landing/landing3.dart';
import 'package:daily_diary/pages/landing/landing4.dart';
import 'package:daily_diary/pages/root.dart';
import 'package:daily_diary/themes/custom_theme.dart';
import 'package:daily_diary/utils/auth.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(CustomTheme(
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/landing1': (context) => Landing1(),
        '/landing2': (context) => Landing2(),
        '/landing3': (context) => Landing3(),
        '/landing4': (context) => Landing4(),
        '/root': (context) => Root(),
      },
      theme: CustomTheme.of(context),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getCurrentUser().then((FirebaseUser user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/root");
      } else {
        Navigator.pushReplacementNamed(context, "/landing1");
      }
    });
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
  }
}
