import 'package:avatar_glow/avatar_glow.dart';
import 'package:daily_diary/controllers/user_control.dart';
import 'package:daily_diary/widgets/delayed_animation.dart';
import 'package:daily_diary/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddStories extends StatefulWidget{
  final String greeting;
  final DateTime date;

  const AddStories({Key key,@required this.greeting, this.date}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AddStoriesState();

}

class _AddStoriesState extends State<AddStories>{

  String _name = " ";
  DateTime _selectedDate;
  List<String> _months = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedDate = widget.date;
    });
    UserControl().getName().then((String name){
      setState(() {
        _name = name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [_primary, _accent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: firstPage()
      ),
    );
  }

  Widget firstPage(){
    int duration = 500;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          AvatarGlow(
            endRadius: 70,
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
                  child: Logo(size: 180),
                  radius: 50.0,
                )),
          ),
          SizedBox(height: 30,),
          DelayedAnimation(
            delay: duration,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "${widget.greeting.replaceAll(",", " ")} $_name, ready to create a new story?",style: TextStyle(fontSize: 27,fontWeight: FontWeight.normal,color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Spacer(),
          DelayedAnimation(
            delay: duration+300,
            child: GestureDetector(
              onTap: ()=>_selectDate(context),
              child: Container(
                child: Text("${_months.elementAt(_selectedDate.month-1)} ${_selectedDate.day}",style: TextStyle(fontSize: 25,color: Colors.white70),),
              ),
            ),
          ),
          Spacer(),
          DelayedAnimation(
            delay: duration+600,
            child: Container(
              padding: EdgeInsets.only(left: 30,right: 30,bottom: 60),
              width: double.maxFinite,
              child: RaisedButton(
                elevation: 10,
                color: Colors.white,
                onPressed: (){

                },
                child: Text("LET'S DO IT!",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w800,fontSize: 17),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await RoundedDatePicker.show(context,
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
          accentColor: Theme.of(context).accentColor,
        ),
        initialDate: _selectedDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(widget.date.year,widget.date.month,widget.date.day+1),
        borderRadius: 16);
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
}