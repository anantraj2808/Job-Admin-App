import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

Future createUser(BuildContext context) async {
  Admin userProvider = Provider.of<Admin>(context,listen: false);
  String url = BASE_API + CREATE;

  dynamic map = {
      'company' : userProvider.companyName,
      'name' : userProvider.name,
      'email' : userProvider.email,
      'phone' : userProvider.phoneNumber
  };

  final http.Response response = await http.post(
      url,
      body: json.encode(map),
      headers: <String,String>{
          "Content-Type" : "application/json"
      }
  );

  print("Create Profile Response code = " + response.statusCode.toString());
  var responseBody = jsonDecode(response.body);
  var data = responseBody['data'];
  //print("User Data = " + data.toString());

  if (response.statusCode == 200){
    Fluttertoast.showToast(
        msg: 'Email Sent \:\)',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: BLACK,
        textColor: WHITE,
        fontSize: 16.0
    );
//      await SharedPrefs().setUserJWTSharedPrefs(responseBody['token']);
//      await SharedPrefs().setUserLoggedInStatusSharedPrefs(true);
//      userProvider.setUid(data['_id']);
//      userProvider.setName(data['name']);
//      userProvider.setEmail(data['email']);
//      userProvider.setCompanyName(data['company']);
//      userProvider.setPhoneNumber(data['phone']);
      return true;
  }

  Fluttertoast.showToast(
      msg: 'Some unknown error occured \:\(',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: BLACK,
      textColor: WHITE,
      fontSize: 16.0
  );
  return false;

}