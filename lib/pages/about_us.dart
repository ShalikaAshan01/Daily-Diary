import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  final Color _color1 = Color(0xFF233355);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color1,
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Logo(
                  size: 180,
                )),
                Expanded(
                    child: Text(
                  "Daily Diary",
                  style: TextStyle(fontSize: 28),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
