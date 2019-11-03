import 'package:daily_diary/themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme extends StatefulWidget {
  final Widget child;
  final MyThemeKeys initialThemeKey;
  const CustomTheme({
    Key key,
    this.initialThemeKey,
    @required this.child,
  }) : super(key: key);

  @override
  CustomThemeState createState() => CustomThemeState();

  static ThemeData of(BuildContext context) {
    _CustomTheme inherited =
        (context.inheritFromWidgetOfExactType(_CustomTheme) as _CustomTheme);
    return inherited.data.theme;
  }

  static CustomThemeState instanceOf(BuildContext context) {
    _CustomTheme inherited =
        (context.inheritFromWidgetOfExactType(_CustomTheme) as _CustomTheme);
    return inherited.data;
  }
}

class _CustomTheme extends InheritedWidget {
  final CustomThemeState data;

  _CustomTheme({
    this.data,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

class CustomThemeState extends State<CustomTheme> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  void initState() {
    get().then((ThemeData theme) {
      setState(() {
        _theme = theme;
      });
    });

//    _theme = MyThemes.getThemeFromKey(widget.initialThemeKey);
    super.initState();
  }

  void save(MyThemeKeys themeKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", themeKey.toString());
  }

  Future<ThemeData> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.get("theme");

    if (theme == null) return MyThemes.theme1;
    switch (theme) {
      case "MyThemeKeys.Theme1":
        return MyThemes.theme1;
      case "MyThemeKeys.Theme2":
        return MyThemes.theme2;
      case "MyThemeKeys.Theme3":
        return MyThemes.theme3;
      case "MyThemeKeys.Theme4":
        return MyThemes.theme4;
      case "MyThemeKeys.Theme5":
        return MyThemes.theme5;
      case "MyThemeKeys.Theme6":
        return MyThemes.theme6;
      default:
        return MyThemes.theme1;
    }
  }

  void changeTheme(MyThemeKeys themeKey) {
    setState(() {
      _theme = MyThemes.getThemeFromKey(themeKey);
      save(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTheme(
      data: this,
      child: widget.child,
    );
  }
}
