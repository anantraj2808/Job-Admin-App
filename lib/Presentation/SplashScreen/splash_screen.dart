import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: 100.0,
            width: 100.0,
            child: Image.asset('assets/images/app_icon.png')),
        ),
      ),
    );
  }
}
