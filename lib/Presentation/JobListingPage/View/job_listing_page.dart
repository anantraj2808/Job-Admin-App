import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/JobDetailsPage/job_details_page.dart';
import 'package:job_admin_app/Presentation/JobListingPage/Widgets/job_listing_card.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/job.dart';

class JobListingPage extends StatefulWidget {

  final List<Job> createdJobsList;
  JobListingPage({this.createdJobsList});

  @override
  _JobListingPageState createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {

  List<Job> createdJobsList;

  @override
  void initState() {
    super.initState();
    createdJobsList = widget.createdJobsList;
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: WHITE,
        title: RegularTextRegCenter("Jobs you\'ve created", 24.0, BLACK, BALOO),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.keyboard_arrow_left,color: BLACK,size: 28.0,),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: ht,
          child: ListView.builder(
            itemCount: createdJobsList.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => JobDetailsPage(job: createdJobsList[index],)
                  ));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: ht * 0.013),
                  height: 130.0,
                  child: jobListingCard(context, createdJobsList[index], index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
