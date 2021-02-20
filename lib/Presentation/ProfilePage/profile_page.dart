import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/services/change_password.dart';
import 'package:job_admin_app/services/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController passwordTEC = TextEditingController();
  TextEditingController oldPasswordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();
  TextEditingController companyNameTEC = TextEditingController();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  bool isLoading = false;
  bool isEdited = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setText();
  }

  setText(){
    Admin userProvider = Provider.of<Admin>(context,listen: false);
    companyNameTEC.text = userProvider.companyName;
    nameTEC.text = userProvider.name;
    emailTEC.text = userProvider.email;
    phoneTEC.text = userProvider.phoneNumber;
  }

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

  editProfileRequest() async {
    Admin user = Provider.of<Admin>(context,listen: false);
    user.setCompanyName(companyNameTEC.text);
    user.setName(nameTEC.text);
    user.setEmail(emailTEC.text);
    user.setPhoneNumber(phoneTEC.text);
    setState(() {
      isLoading = true;
    });
    await editProfile(context).then((val){
      if (val){
        Fluttertoast.showToast(
            msg: 'Profile Edited Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: BLACK,
            textColor: WHITE,
            fontSize: 16.0
        );
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        backgroundColor: WHITE,
        elevation: 0,
//        actions: [
//          GestureDetector(
//            onTap: (){
//              changePasswordRequest();
//            },
//            child: Container(
//              margin: EdgeInsets.symmetric(horizontal: 20.0),
//              height: 24.0,
//              width: 24.0,
//              child: Image.asset('assets/images/password_change.png'),
//            ),
//          )
//        ],
      ),
      body: Stack(
        children: [
          if(isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: SafeArea(
              child: Container(
                width: wd,
                padding: EdgeInsets.only(top: 20.0,left: 15.0,right: 15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: BLACK_26,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(Icons.perm_identity,color: BLACK,size: 50.0,),
                          ),
                        ),
                        SizedBox(height: 50.0,),
                        TextFormField(
                          enabled: isEdited,
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
                        SizedBox(height: 15.0,),
                        TextFormField(
                          enabled: isEdited,
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
                            labelText: "Name",
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
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: emailTEC,
                          validator: (String val){
                            if (val.toString().trim().length == 0) return "Enter valid email";
                            return null;
                          },
                          style: TextStyle(color: BLACK),
                          enabled: false,
                          cursorHeight: 20.0,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Email (Non-Editable)",
                            labelStyle: TextStyle(color: DARK_GREY),
                            prefixIcon: Icon(
                              Icons.email,
                              color: BLACK,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: BLACK, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: DARK_GREY, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        TextFormField(
                          enabled: isEdited,
                          controller: phoneTEC,
                          validator: (String val){
                            if (val.toString().trim().length != 0) return "Enter valid Phone Number";
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
                              Icons.phone_android_outlined,
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
                        SizedBox(height: 30.0,),
                        FlatButton(
                          onPressed: () => showPasswordChangeDialog(context),
                          color: BLACK,
                          child: RegularTextReg("Change Password", 18.0, WHITE, BALOO),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            isEdited = !isEdited;
            if(!isEdited){
              editProfileRequest();
            }
          });
        },
        backgroundColor: BLACK,
        child: Icon(isEdited ? Icons.check : Icons.edit),
      ),
    );
  }
}
