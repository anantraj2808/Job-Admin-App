import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/WidgetsAndStyles/transitions.dart';
import 'package:job_admin_app/constants/colors.dart';

class PasswordPage extends StatefulWidget {

  final String email;
  PasswordPage({this.email});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WHITE,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ht * 0.015),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: ht * 0.35,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: ht * 0.13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypewriterAnimatedTextKit(
                        isRepeatingAnimation: true,
                        totalRepeatCount: 2,
                        repeatForever: false,
                        speed: const Duration(milliseconds: 100),
                        pause: const Duration(milliseconds: 1000),
                        text: [
                          "Glad to have\nyou back here!",
                        ],
                        textStyle: TextStyle(
                            fontSize: 50.0,
                            fontFamily: 'yanone',
                            height: 1.0,
                            letterSpacing: 2.0,
                            color: BLACK
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )
                ),
                SizedBox(height: ht*0.06,),
                Text('Just enter your Password!',style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'yanone',
                    height: 1.0,
                    //letterSpacing: 2.0,
                    color: BLACK
                ),),
                SizedBox(height: ht * 0.05,),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: ht * 0.016),
                    child: TextFormField(
                      style: TextStyle(color: BLACK),
                      obscureText: isObscured,
                      cursorColor: BLACK,
                      cursorHeight: 20.0,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: BLACK),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: BLACK,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye,color: BLACK,),
                          onPressed: (){
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
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
                    //Navigator.of(context).push(createRoute(PasswordPage()));
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
      ),
    );
  }
}
