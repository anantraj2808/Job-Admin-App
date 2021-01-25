import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/constants/colors.dart';

class DetailsForm extends StatefulWidget {
  @override
  _DetailsFormState createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  bool isPwObscured = true;
  bool isConfirmPwObscured = true;

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
                    height: ht * 0.26,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: ht * 0.045),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Looking for',style: TextStyle(
                            fontSize: 50.0,
                            fontFamily: 'yanone',
                            height: 1.0,
                            letterSpacing: 2.0,
                            color: BLACK
                        ),),
                        TypewriterAnimatedTextKit(
                          isRepeatingAnimation: true,
                          repeatForever: true,
                          speed: const Duration(milliseconds: 100),
                          pause: const Duration(milliseconds: 1000),
                          text: [
                            "a Plumber?",
                            "a Carpenter?",
                            "an Electrician?",
                            "a Driver?",
                            "a Motor Mechanic?",
                            "a Home-Maid?",
                            "a Washer-Man?",
                            "a Sweeper?",
                            "a Gatekeeper?",
                          ],
                          textStyle: TextStyle(
                              fontSize: 45.0,
                              fontFamily: 'yanone',
                              height: 1.0,
                              letterSpacing: 2.0,
                              color: BLACK
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text('We are here to assist!',style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'yanone',
                            height: 1.0,
                            letterSpacing: 2.0,
                            color: BLACK
                        ),),
                      ],
                    )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Just enter your Details!',style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'yanone',
                      height: 1.0,
                      //letterSpacing: 2.0,
                      color: BLACK
                  ),),
                ),
                SizedBox(height: ht * 0.02,),
                TextFormField(
                  style: TextStyle(color: BLACK),
                  cursorColor: BLACK,
                  cursorHeight: 20.0,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Organisation Name",
                    labelStyle: TextStyle(color: BLACK),
                    prefixIcon: Icon(
                      Icons.people,
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
                ),
                SizedBox(height: ht * 0.013,),
                TextFormField(
                  style: TextStyle(color: BLACK),
                  cursorColor: BLACK,
                  cursorHeight: 20.0,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    labelStyle: TextStyle(color: BLACK),
                    prefixIcon: Icon(
                      Icons.person,
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
                ),
                SizedBox(height: ht * 0.013,),
                TextFormField(
                  style: TextStyle(color: BLACK),
                  cursorColor: BLACK,
                  cursorHeight: 20.0,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(color: BLACK),
                    prefixIcon: Icon(
                      Icons.phone_in_talk,
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
                ),
                SizedBox(height: ht * 0.013,),
                TextFormField(
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
                ),
                SizedBox(height: ht * 0.013,),
                Container(
                    child: TextFormField(
                      style: TextStyle(color: BLACK),
                      obscureText: isPwObscured,
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
                              isPwObscured = !isPwObscured;
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
                SizedBox(height: ht * 0.013,),
                Container(
                    child: TextFormField(
                      style: TextStyle(color: BLACK),
                      obscureText: isConfirmPwObscured,
                      cursorColor: BLACK,
                      cursorHeight: 20.0,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: BLACK),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: BLACK,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye,color: BLACK,),
                          onPressed: (){
                            setState(() {
                              isConfirmPwObscured = !isConfirmPwObscured;
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
                SizedBox(height: ht * 0.02,),
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
