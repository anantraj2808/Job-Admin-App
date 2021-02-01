import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/post_a_job_form.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/WidgetsAndStyles/transitions.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Admin userProvider = Provider.of<Admin>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(userProvider.email),
              Text(userProvider.name),
              Text(userProvider.companyName),
              Text(userProvider.phoneNumber),
              Text(userProvider.uid)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.of(context).push(createRoute(PostJobForm()));
        },
        child: Container(
          width: ht*0.17,
          height: ht*0.052,
          decoration: BoxDecoration(
            color: BLACK,
            borderRadius: BorderRadius.circular(ht*0.013)
          ),
          child: Center(child: RegularTextMedCenter("Post a Job", ht*0.027, WHITE, BALOO)),
        ),
      ),
    );
  }
}
