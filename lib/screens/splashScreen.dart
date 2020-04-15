import 'dart:async';
import '../screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(57, 57, 59, 0.9),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "assets/icon.png",
                  width: mq.size.width / 2 - 10,
                  height: mq.size.height * .75,
                ),
              ),
              Container(
                height: mq.size.height * .24,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children:[
                        TextSpan(text:"COVID-19",style: TextStyle(fontSize: 45, color: Colors.grey),),
                        TextSpan(text:"Tracker",style: TextStyle(fontSize: 18, color: Colors.grey),), 
                      ]
                    ),
                    //style: TextStyle(fontSize: 45, color: Colors.grey),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
