import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/transitions.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/services/login.dart';

import '../../home.dart';

class PasswordPage extends StatefulWidget {

  final String email;
  PasswordPage({this.email});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  TextEditingController passwordTEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;
  bool isLoading = false;

  loginRequest(BuildContext context, String email, String password) async {
    setState(() {
      isLoading = true;
    });
    bool isPasswordMatched = false;
    await login(context, email, password).then((val){
      print("Is password matched = " + val.toString());
      isPasswordMatched = val;
    });
    setState(() {
      isLoading = false;
    });
    if (isPasswordMatched){
      Navigator.of(context).pushAndRemoveUntil(createRoute(Home()),(route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WHITE,
      body: Stack(
        children: [
          if (isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: SafeArea(
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
                                    color: THEME_BLACK_BLUE
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
                          color: THEME_BLACK_BLUE
                      ),),
                      SizedBox(height: ht * 0.05,),
                      Form(
                        key: _formKey,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: ht * 0.016),
                            child: TextFormField(
                              controller: passwordTEC,
                              style: TextStyle(color: THEME_BLACK_BLUE),
                              obscureText: isObscured,
                              cursorColor: THEME_BLACK_BLUE,
                              cursorHeight: 20.0,
                              autofocus: false,
//                              validator: (String val){
//                                if (val.length <= 5) return "Enter valid credentials";
//                                return null;
//                              },
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: THEME_BLACK_BLUE),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: THEME_BLACK_BLUE,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye,color: THEME_BLACK_BLUE,),
                                  onPressed: (){
                                    setState(() {
                                      isObscured = !isObscured;
                                    });
                                  },
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: THEME_BLACK_BLUE, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: THEME_BLACK_BLUE, width: 1.0),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: ht * 0.115,),
                      InkWell(
                        onTap: (){
                          if(_formKey.currentState.validate()){
                            loginRequest(context, widget.email, passwordTEC.text);
                          }
                        },
                        child: Container(
                          height: ht * 0.065,
                          width: ht * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: THEME_BLACK_BLUE,
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
          )
        ],
      ),
    );
  }
}
