import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/DetailsFormPage/details_form.dart';
import 'package:job_admin_app/Presentation/PasswordPage/password_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/transitions.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/services/check_email.dart';
import 'package:shimmer/shimmer.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {

  TextEditingController emailTEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<bool> checkEmailRequest(String email) async {
    setState(() {
      isLoading = true;
    });
    await checkEmail(email).then((val){
      print("Val = " + val.toString());
      setState(() {
        isLoading = false;
      });
      if(val) return true;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WHITE,
      body: Stack(
        children: [
          if(isLoading) loader(context),
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
                        child:
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
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
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
                          )),
                      SizedBox(height: ht * 0.115,),
                      InkWell(
                        onTap: () async {
                          if(_formKey.currentState.validate()){
                            bool isExistingUser = false;
                            isExistingUser = await checkEmailRequest(emailTEC.text);
                            if (isExistingUser) Navigator.of(context).push(createRoute(PasswordPage(email: emailTEC.text,)));
                            else Navigator.of(context).push(createRoute(DetailsForm(email: emailTEC.text,)));
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
          )
        ],
      ),
    );
  }
}


