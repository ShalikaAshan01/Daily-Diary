import 'package:daily_diary/controllers/user_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserImage extends StatelessWidget {
  final double size;

  const UserImage({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserControl().getDisplayImage(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data != null) {
            return Image(
              image: NetworkImage(snapshot.data),
            );
          }
          return Icon(
            FontAwesomeIcons.camera,
            color: Colors.white60,
            size: 50,
          );
        });
  }
}
