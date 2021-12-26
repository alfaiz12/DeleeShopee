import 'dart:async';

import 'package:ebasket/main.dart';
import 'package:flutter/material.dart';
class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState(){
    super.initState();
    debugPrint("Started the Splash");
    Timer(Duration(seconds: 5),callbackf);
  }

  void callbackf(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ScreensController()));;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/logods.png"),
          ],
        ),
      ),
    );
  }
}
