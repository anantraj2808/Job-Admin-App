import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/HomePage/home_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/services/get_created_jobs.dart';
import 'package:job_admin_app/services/set_details.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'models/admin.dart';
import 'models/job.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isLoading = false;
  bool isDetailSet = false;
  List<Job> createdJobList = [];

  @override
  void initState() {
    //setUserDetailsRequest();
    super.initState();
  }

  setUserDetailsRequest() async {
    String jwt = await SharedPrefs().getUserJWTSharedPrefs();
    await setUserDetails(context, jwt).then((val){

    });
  }

  @override
  Widget build(BuildContext context) {
    Admin userProvider = Provider.of<Admin>(context);
    return Scaffold(
      body: Stack(
        children: [
          if (isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: HomePage(fromHome: true,)
          )
        ],
      )
    );
  }
}
