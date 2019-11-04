import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Home>{

  PageController ctrl;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    ctrl = PageController(
      initialPage: currentPage,
      viewportFraction: 0.8,
    );

  }

  @override
  Widget build(BuildContext context) {
    Color _primary = Theme.of(context).primaryColor;
    Color _accent = Theme.of(context).accentColor;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: PageView.builder(
          controller: ctrl,
          onPageChanged: (value){
            setState(() {
              currentPage = value;
            });
          },
          itemBuilder: (context, int currentIdx){
            if(currentIdx == 0){
              return Container(color: Colors.redAccent,);
            }
            bool active = currentIdx == currentPage;
            return customCards(active);
          },
        ),
      )
    );
  }
  Widget customCards(bool active){
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 10,left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://en.es-static.us/upl/2018/06/sun-pillar-6-25-2018-Peter-Gipson-sq.jpg'),
          ),
          boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]
      ),
      child:Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("20",style: TextStyle(fontSize: 20),),
                    ),
                    SizedBox(height: 5,),

                    Container(
                      child: Text("OCT"),
                    ),
                    Container(
                      child: Text("2019",style: TextStyle(color: Colors.white54),),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  child: Icon(Icons.favorite_border,color: Colors.white,),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

}