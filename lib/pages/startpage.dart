import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      child:  Center(
        child: ListView(
            children: <Widget>[
              headerSection(),
              buttonSection(),
            ],
          ),
      ),
      ),
    );
  }

   Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 120.0),
      child: Text("TouchMEM",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontFamily: "Helvetica Neue",
              fontWeight: FontWeight.bold)),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => GamePage()), (Route<dynamic> route) => false);
        },
        elevation: 0.0,
        color: Colors.black,
        child: Text(" Click to Start", style: TextStyle(color: Colors.white70,fontSize: 20.0,
              fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

}

