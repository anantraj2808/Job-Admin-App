import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/EmailPage/email_page.dart';
import 'package:job_admin_app/home.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Admin()),
      ],
      builder: (context,_){
        final Admin userProvider = Provider.of<Admin>(context, listen: false);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Job Admin App',
          home:
          FutureBuilder(
              future: SharedPrefs().getUserLoggedInStatusSharedPrefs(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  return Container(child: Text('Anant',style: TextStyle(color: RED,fontSize: 25.0),),);
                return (snapshot.hasData && snapshot.data) ? Home(isUserLoggedIn: true,) : EmailPage();
              }
          ),
        );
      },
    );
  }
}