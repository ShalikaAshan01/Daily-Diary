import 'package:daily_diary/controllers/user_control.dart';
import 'package:flutter/cupertino.dart';

class Name extends StatelessWidget {
  final TextStyle textStyle;

  const Name({Key key, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserControl().getName(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data != null) {
            return Text(
              snapshot.data,
              style: textStyle,
            );
          }
          return Text("");
        });
  }
}
