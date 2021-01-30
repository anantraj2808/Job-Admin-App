import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/constants/apis.dart';

Future<bool> checkEmail(String email) async {
  String url = BASE_API + EMAIL_CHECK + email;

  http.Response response = await http.get(url);

  print("Check email response code = " + response.statusCode.toString());
  var responseBody = jsonDecode(response.body);

  if (response.statusCode == 200){
    print("Is existing user = " + responseBody['existingUser'].toString());
    if (responseBody['existingUser']) return true;
    return false;
  }
  return false;
}