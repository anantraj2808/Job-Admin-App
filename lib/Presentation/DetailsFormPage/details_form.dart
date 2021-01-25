import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:provider/provider.dart';

class DetailsForm extends StatefulWidget {
  @override
  _DetailsFormState createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  bool isPwObscured = true;
  bool isConfirmPwObscured = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController companyNameTEC = TextEditingController();
  TextEditingController phoneNumberTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();

  requestUserCreate(Admin user, String password){

  }

  @override
  Widget build(BuildContext context) {
    Admin userProvider = Provider.of<Admin>(context);
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WHITE,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ht * 0.015),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    controller: companyNameTEC,
                    validator: (String val){
                      if (val.toString().trim().length == 0) return "Enter valid Organisation Name";
                      return null;
                    },
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
                    controller: nameTEC,
                    validator: (String val){
                      if (val.toString().trim().length == 0) return "Enter valid Name";
                      return null;
                    },
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
                    controller: phoneNumberTEC,
                    validator: (String val){
                      if (val.toString().trim().length != 10) return "Enter valid Phone Number";
                      return null;
                    },
                    style: TextStyle(color: BLACK),
                    cursorColor: BLACK,
                    cursorHeight: 20.0,
                    autofocus: false,
                    keyboardType: TextInputType.number,
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
                    controller: emailTEC,
                    validator: (value){
                      return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)
                          ? null
                          : "Please enter valid Email ID";
                    },
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
                        controller: passwordTEC,
                        validator: (String val){
                          if (val.toString().trim().length == 0) return "Create a password";
                          return null;
                        },
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
                        controller: confirmPasswordTEC,
                        validator: (String val){
                          if (val.toString().trim().length == 0) return "Confirm your password";
                          return null;
                        },
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
                      if(passwordTEC.text != confirmPasswordTEC.text) {
                        Fluttertoast.showToast(
                            msg: "Passwords do not match",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: WHITE,
                            textColor: BLACK,
                            fontSize: 16.0
                        );
                      }
                      if (_formKey.currentState.validate() && passwordTEC.text == confirmPasswordTEC.text){
                        userProvider.setName(nameTEC.text);
                        userProvider.setCompanyName(companyNameTEC.text);
                        userProvider.setPhoneNumber(phoneNumberTEC.text);
                        userProvider.setEmail(emailTEC.text);
                        requestUserCreate(userProvider,passwordTEC.text);
                      }
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
      ),
    );
  }
}
