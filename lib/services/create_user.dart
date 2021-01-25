import 'dart:convert';
import 'package:job_admin_app/constants/apis.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/services/shared_preferences.dart';

Future createUser(Admin user, String password) async {
  String url = BASE_API + CREATE;

  dynamic map = {
      'company' : user.companyName,
      'name' : user.name,
      'password' : password,
      'email' : user.email,
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

  if (response.statusCode == 200){
      await SharedPrefs().setUserJWTSharedPrefs(responseBody['token']);
      await SharedPrefs().setUserLoggedInStatusSharedPrefs(true);
  }

}