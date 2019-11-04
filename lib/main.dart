import 'package:daily_diary/pages/home.dart';
import 'package:daily_diary/pages/landing/landing1.dart';
import 'package:daily_diary/pages/landing/landing2.dart';
import 'package:daily_diary/pages/landing/landing3.dart';
import 'package:daily_diary/pages/landing/landing4.dart';
import 'package:daily_diary/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then((_) {
        runApp(
            CustomTheme(
              child: MyApp(),)
        );
      });
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
      '/':(context)=>Landing2(),
        '/landing1':(context)=>Landing1(),
        '/landing2':(context)=>Landing2(),
        '/landing3':(context)=>Landing3(),
        '/landing4':(context)=>Landing4(),
        '/home':(context)=>Home(),
      },
      theme: CustomTheme.of(context),
    );
  }

}