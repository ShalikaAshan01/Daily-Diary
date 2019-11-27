import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({Key key, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage("assets/imgs/logo.png"),
      width: size,
      height: size,
    );
  }
}
