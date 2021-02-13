import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/services/change_password.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController oldPasswordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();
  bool isLoading = false;

  changePasswordRequest() async {
    setState(() {
      isLoading = true;
    });
    await changePassword(oldPasswordTEC.text, passwordTEC.text).then((val){
      if(val) {
        Fluttertoast.showToast(
            msg: "Password Change Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: BLACK,
            textColor: WHITE,
            fontSize: 16.0
        );
        return false;
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  showPasswordChangeDialog(BuildContext context) {
    bool isPwObscured = true;
    bool isOldPwObscured = true;
    bool isConfirmPwObscured = true;
    var ht = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: WHITE,
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            height: 300.0,
            child: Column(
              children: [
                SizedBox(
                  height: ht * 0.02,
                ),
                Container(
                    height: ht * 0.065,
                    child: TextFormField(
                      controller: oldPasswordTEC,
                      validator: (String val) {
                        if (val.toString().trim().length <= 5)
                          return "Enter a valid password";
                        return null;
                      },
                      style: TextStyle(color: BLACK),
                      obscureText: isOldPwObscured,
                      cursorColor: BLACK,
                      cursorHeight: 20.0,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Old / Temporary Password",
                        labelStyle: TextStyle(color: BLACK,fontSize: 12.0),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: BLACK,
                        ),
//                        suffixIcon: IconButton(
//                          icon: Icon(
//                            Icons.remove_red_eye,
//                            color: BLACK,
//                          ),
//                          onPressed: () {
//                            setState(() {
//                              isOldPwObscured = !isOldPwObscured;
//                              print("Is old PW obscured = $isOldPwObscured");
//                            });
//                          },
//                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BLACK, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BLACK, width: 1.0),
                        ),
                      ),
                    )),
                SizedBox(
                  height: ht * 0.02,
                ),
                Container(
                    height: ht * 0.065,
                    child: TextFormField(
                      controller: passwordTEC,
                      validator: (String val) {
                        if (val.toString().trim().length == 0)
                          return "Create a password";
                        if (val.toString().trim().length <= 5)
                          return "Create a stronger password";
                        return null;
                      },
                      style: TextStyle(color: BLACK),
                      obscureText: isPwObscured,
                      cursorColor: BLACK,
                      cursorHeight: 20.0,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        labelStyle: TextStyle(color: BLACK,fontSize: 12.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: BLACK,
                        ),
//                        suffixIcon: IconButton(
//                          icon: Icon(
//                            Icons.remove_red_eye,
//                            color: BLACK,
//                          ),
//                          onPressed: () {
//                            setState(() {
//                              isPwObscured = !isPwObscured;
//                            });
//                          },
//                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BLACK, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BLACK, width: 1.0),
                        ),
                      ),
                    )),
                SizedBox(
                  height: ht * 0.02,
                ),
                Container(
                    height: ht * 0.065,
                    child: TextFormField(
                      controller: confirmPasswordTEC,
                      validator: (String val) {
                        if (val.toString().trim().length == 0)
                          return "Confirm your password";
                        return null;
                      },
                      style: TextStyle(color: BLACK),
                      obscureText: isConfirmPwObscured,
                      cursorColor: BLACK,
                      cursorHeight: 20.0,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Re-enter new Password",
                        labelStyle: TextStyle(color: BLACK,fontSize: 12.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: BLACK,
                        ),
//                        suffixIcon: IconButton(
//                          icon: Icon(
//                            Icons.remove_red_eye,
//                            color: BLACK,
//                          ),
//                          onPressed: () {
//                            setState(() {
//                              isConfirmPwObscured = !isConfirmPwObscured;
//                            });
//                          },
//                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BLACK, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BLACK, width: 1.0),
                        ),
                      ),
                    )),
                SizedBox(
                  height: ht * 0.02,
                ),
                FlatButton(
                  color: BLACK,
                  child: RegularTextMed("Confirm", 18.0, WHITE, BALOO),
                  onPressed: (){
                    if (passwordTEC.text == confirmPasswordTEC.text){
                      Navigator.pop(context);
                      changePasswordRequest();
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: 'Passwords do not match !',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: BLACK,
                          textColor: WHITE,
                          fontSize: 16.0
                      );
                      return false;
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if(isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: SafeArea(
              child: Center(
                child: FlatButton(
                  color: Colors.orange,
                  child: Text("Change Password"),
                  onPressed: () {
                    showPasswordChangeDialog(context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
