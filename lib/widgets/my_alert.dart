import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlert extends StatefulWidget {
  final List<Widget> actions;
  final String title;
  final String content;

  const MyAlert({Key key, this.actions, @required this.title, this.content})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Color(0xFF233355),
        title: Text(
          widget.title.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.redAccent,
              fontStyle: FontStyle.normal,
              fontSize: 18),
        ),
        content: Text(
          widget.content,
          style: TextStyle(fontSize: 17, color: Colors.white70),
        ),
        actions: widget.actions);
  }
}
