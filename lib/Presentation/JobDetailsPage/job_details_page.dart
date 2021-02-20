import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/ApplicantDetailsPage/applicant_details_page.dart';
import 'package:job_admin_app/Presentation/HomePage/home_page.dart';
import 'package:job_admin_app/Presentation/JobDetailsPage/Widget/applicant_tile.dart';
import 'package:job_admin_app/Presentation/JobDetailsPage/selected_profile_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/applicant.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:job_admin_app/services/get_all_applicants.dart';
import 'package:job_admin_app/services/toggle_job_status.dart';

import '../../home.dart';

class JobDetailsPage extends StatefulWidget {

  final Job job;
  JobDetailsPage({this.job});

  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {

  Job job;
  String payBasis = "";
  bool isLoading = false;
  bool jobStatus = true;
  List<Applicant> applicantList = [];
  List<Applicant> acceptedList = [];
  List<Applicant> inReviewList = [];

  @override
  void initState() {
    super.initState();
    job = widget.job;
    payBasis = job.payBasis == "Per Day" ? "day" : "month";
    jobStatus = job.isActive == "true" ? true : false;
    getApplicantsRequest();
  }

  toggleJobStatusRequest(bool jobStatus) async {
    setState(() {
      isLoading = true;
    });
    await toggleJobStatus(job.id, jobStatus).then((value){

    });
    setState(() {
      isLoading = false;
    });
  }

  getApplicantsRequest() async {
    setState(() {
      isLoading = true;
    });
    await getAllApplicants(job.id).then((val){
      for (int i=0 ; i<val.length ; i++){
        if(val[i].appointmentStatus == "applied") applicantList.add(val[i]);
        if(val[i].appointmentStatus == "Accepted") acceptedList.add(val[i]);
        if(val[i].appointmentStatus == "In-Review") inReviewList.add(val[i]);
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: Stack(
        children: [
          if(isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                        centerTitle: true,
                        backgroundColor: WHITE,
                        leading:
                        //Container(),
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,color: BLACK,),
                          onPressed: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => Home()
                            ), (route) => false);
                          },
                        ),
                        title: Container(
                          transform: Matrix4.translationValues(5, 0, 0),
                          margin: EdgeInsets.only(right: 20.0,top: 5.0),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RegularTextMed(job.profession, 22.0, BLACK, BALOO),
                              Container(
                                transform: Matrix4.translationValues(0, -5, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on_outlined,color: BLACK,),
                                    SizedBox(width: 5.0,),
                                    Flexible(child: RegularTextRegOverflow("${job.city}\, ${job.state}", 18.0, BLACK, 1, BALOO)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 18,horizontal: 8.0),
                            child: GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text("Are you sure want to make this job ${jobStatus ? "Inactive" : "Active"} ?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            setState(() {
                                              jobStatus = !jobStatus;
                                              toggleJobStatusRequest(jobStatus);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: CustomSwitchButton(
                                backgroundColor: jobStatus ? LIGHT_GREEN : LIGHT_RED,
                                unCheckedColor: RED,
                                animationDuration: Duration(milliseconds: 400),
                                checkedColor: GREEN,
                                checked: jobStatus,
                              ),
                            ),
                          ),
                        ],
                        floating: false,
                        expandedHeight: 310.0,
                        pinned: true,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
//                    border: Border(
//                      bottom: BorderSide(
//                        color: BLACK
//                      )
//                    )
                          ),
                          //margin: EdgeInsets.only(top: 50.0),
                          padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 60.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 10.0,),
                                Row(
                                  children: [
                                    Icon(Icons.monetization_on_outlined,color: BLACK,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("₹ ${job.salary} /${job.payBasis == "Per Day" ? " day" : " month"}", 22.0, BLACK, BALOO),
                                    Spacer(),
                                    Icon(Icons.timer,color: BLACK,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("${job.dutyType}", 22.0, BLACK, BALOO),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.format_list_numbered,color: BLACK,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("${job.openings} Openings", 22.0, BLACK, BALOO),
                                    Spacer(),
                                    Icon(Icons.language_outlined,color: BLACK,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("${job.language}", 22.0, BLACK, BALOO),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    RegularTextReg("•", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("Job Desc : ", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextMed("${job.jobDescription}", 18.0, BLACK, BALOO),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    RegularTextReg("•", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("Min Qualification : ", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    Flexible(child: RegularTextMedOverflow("${job.minimumQualifications}", 18.0, BLACK, 1, BALOO)),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    RegularTextReg("•", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("Min Experience : ", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    Flexible(child: RegularTextMedOverflow("${job.experience}", 18.0, BLACK, 1, BALOO)),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    RegularTextReg("•", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("Work timings : ", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextMed("${job.workTimings}", 18.0, BLACK, BALOO),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    RegularTextReg("•", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("Address : ", 18.0, BLACK, BALOO),
                                    SizedBox(width: 5.0,),
                                    RegularTextMed("${job.address}", 18.0, BLACK, BALOO),
                                  ],
                                ),
//                                SizedBox(height: 15.0,),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: [
//                                    RegularTextReg("Inactive  ", 16.0, BLACK, BALOO),
//                                    GestureDetector(
//                                      onTap: (){
//                                        setState(() {
//                                          jobStatus = !jobStatus;
//                                        });
//                                      },
//                                      child: CustomSwitchButton(
//                                        backgroundColor: jobStatus ? LIGHT_GREEN : LIGHT_RED,
//                                        unCheckedColor: RED,
//                                        animationDuration: Duration(milliseconds: 400),
//                                        checkedColor: GREEN,
//                                        checked: jobStatus,
//                                      ),
//                                    ),
//                                    RegularTextReg("   Active", 16.0, BLACK, BALOO),
//                                  ],
//                                )
                              ],
                            ),
                          ),
                        )
                    ),
                  ];
                },
                body: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: BLACK
                          )
                      )
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: applicantList.length == 0 && acceptedList.length == 0 && inReviewList.length == 0 ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/images/no_applicant.png'),
                        ),
                        SizedBox(height: 20.0,),
                        RegularTextMed("No Application received yet", 24.0, BLACK, BALOO)
                      ],
                    ),
                  ) :SingleChildScrollView(
                    child: Column(
                      children: [
                        applicantList.length != 0 ? Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 7.0),
                                alignment: Alignment.centerLeft,
                                child: RegularTextMed("New Applicants", 24.0, BLACK, BALOO)
                            ),
                            SizedBox(width: 10.0,),
                            RegularTextReg("\( ${applicantList.length} \)", 22.0, BLACK, BALOO),
                            Spacer(),
//                            GestureDetector(
//                              onTap: (){
//                                Navigator.push(context, MaterialPageRoute(
//                                  builder: (context) => SelectedProfilesPage(acceptedList: acceptedList,inReviewList: inReviewList,)
//                                ));
//                              },
//                              child: RegularTextReg("VIEW ALL", 18.0, BLUE, BALOO))
                          ],
                        ) : Container(),
                        SizedBox(height: 10.0,),
                        Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: applicantList.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ApplicantDetailsPage(applicant: applicantList[index], isApplicant: true,job: widget.job,)
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  height: 100.0,
                                  child: applicantListTile(context, index, applicantList[index]),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        acceptedList.length != 0 ? Row(
                          children: [
                            Container(
                              height : 10.0,
                              width : 10.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GREEN
                              ),
                            ),
                            RegularTextMed("    Accepted", 24.0, BLACK, BALOO),
                            Spacer(),
                          ],
                        ) : Container(),
                        acceptedList.length != 0 ? SizedBox(height: 10.0,) : Container(),
                        Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: acceptedList.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ApplicantDetailsPage(applicant: acceptedList[index], isApplicant: true,job: widget.job,)
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  height: 100.0,
                                  child: applicantListTile(context, index, acceptedList[index]),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        inReviewList.length != 0 ? Row(
                          children: [
                            Container(
                              height : 10.0,
                              width : 10.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: YELLOW
                              ),
                            ),
                            RegularTextMed("    In-Review", 24.0, BLACK, BALOO),
                            Spacer(),
                          ],
                        ) : Container(),
                        inReviewList.length != 0 ? SizedBox(height: 10.0,) : Container(),
                        Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: inReviewList.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ApplicantDetailsPage(applicant: inReviewList[index], isApplicant: true,job: widget.job,)
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  height: 100.0,
                                  child: applicantListTile(context, index, inReviewList[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
