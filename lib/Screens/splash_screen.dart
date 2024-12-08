import 'package:flutter/material.dart';
import 'dart:async';
import 'main_screen.dart'; // MainScreen으로 이동하기 위해 import

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _visible = true;
      });
    });

    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0, // 보이는 상태 여부
          duration: Duration(seconds: 2), // 페이드 인/아웃 시간
          child: Text(
            'LawReady',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              fontFamily: 'RobotoBlack',
            ),
          ),
        ),
      ),
    );
  }
}

