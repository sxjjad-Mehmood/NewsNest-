import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:newsapp/home.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {

    Timer(Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height*.5,
                child: Image(image: AssetImage("images/splash.jpg")),

              ),
            ),
            SizedBox(height: 2,),
            Center(child: Text("Touch With World\n News",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),)),
            SizedBox(height: 3,),
            SpinKitRipple(
              size: 10,
              color: Colors.blueAccent,
            )
        
          ],
        ),
      )
    );
  }
}
