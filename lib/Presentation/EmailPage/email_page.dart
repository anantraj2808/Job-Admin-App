import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/PasswordPage/password_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/transitions.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WHITE,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ht * 0.015),
          child: Column(
            children: [
              Container(
                height: ht * 0.35,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: ht * 0.13),
                  child:
//              RichText(
//                text: TextSpan(
//                  text: "Hi",
//                  style: TextStyle(color: BLUE,fontSize: 60,fontFamily: 'yanone',height: 1.0,letterSpacing: 2.0),
//                  children: [
//                    TextSpan(text: 're people\nfor your\ndaily needs!',style: TextStyle(color: BLACK,fontSize: 60,fontFamily: 'yanone'))
//                  ]
//                ),
//              ),

//                      Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      Shimmer.fromColors(
//                        child: Text(
//                          'Hi',
//                          style: TextStyle(
//                              color: BLUE,
//                              fontSize: 55,
//                              fontFamily: 'yanone',
//                              height: 1.0,
//                              letterSpacing: 2.0),
//                        ),
//                        baseColor: BLUE,
//                        highlightColor: WHITE,
//                        loop: 3,
//                      ),
//                      Shimmer.fromColors(
//                        child: Text(
//                          're people\nfor your\ndaily needs!',
//                          style: TextStyle(
//                              color: BLACK,
//                              fontSize: 55,
//                              fontFamily: 'yanone',
//                              height: 1.0,
//                              letterSpacing: 2.0),
//                        ),
//                        baseColor: BLACK,
//                        highlightColor: WHITE,
//                        loop: 3,
//                      )
//                    ],
//                  )

                TypewriterAnimatedTextKit(
                  isRepeatingAnimation: true,
                  totalRepeatCount: 2,
                  repeatForever: false,
                  speed: const Duration(milliseconds: 100),
                  pause: const Duration(milliseconds: 1000),
                  text: [
                    "Hi",
                    "Hire people\nfor your\ndaily needs!"
                  ],
                  textStyle: TextStyle(
                      fontSize: 55.0,
                      fontFamily: 'yanone',
                      height: 1.0,
                      letterSpacing: 2.0,
                    color: BLACK
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: ht * 0.115,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: ht * 0.016),
                  child: TextFormField(
                    style: TextStyle(color: BLACK),
                    cursorColor: BLACK,
                cursorHeight: 20.0,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: BLACK),
                  prefixIcon: Icon(
                    Icons.email,
                    color: BLACK,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: BLACK, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: BLACK, width: 1.0),
                  ),
                ),
              )),
              SizedBox(height: ht * 0.115,),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(createRoute(PasswordPage()));
                },
                child: Container(
                  height: ht * 0.065,
                  width: ht * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: BLACK,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text('Continue',style: TextStyle(color: WHITE,fontSize: 18.0),)
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


