import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/JobDetailsPage/Widget/applicant_tile.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/applicant.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:job_admin_app/services/get_all_applicants.dart';

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
  List<Applicant> applicantList = [];

  @override
  void initState() {
    super.initState();
    job = widget.job;
    payBasis = job.payBasis == "Per Day" ? "day" : "month";
    getApplicantsRequest();
  }

  getApplicantsRequest() async {
    setState(() {
      isLoading = true;
    });
    await getAllApplicants(job.id).then((val){
      setState(() {
        applicantList = val;
        for (int i=0 ; i<applicantList[0].occupations.length ; i++){
          print("Applicant Profession = "+applicantList[0].occupations[i].occupation);
        }
      });
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
                            Navigator.pop(context);
                          },
                        ),
                        title: Container(
                          transform: Matrix4.translationValues(-15, 0, 0),
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
                                    RegularTextReg("${job.city}\, ${job.state}", 18.0, BLACK, BALOO),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        floating: false,
                        expandedHeight: 300.0,
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
                                    RegularTextReg("₹ ${job.salary} /${job.payBasis == "Per Day" ? " day" : " month"}", 18.0, BLACK, BALOO),
                                    Spacer(),
                                    Icon(Icons.timer,color: BLACK,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("${job.dutyType}", 18.0, BLACK, BALOO),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    Icon(Icons.format_list_numbered,color: BLACK,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("${job.openings} Openings", 18.0, BLACK, BALOO),
                                    Spacer(),
                                    Icon(Icons.language_outlined,color: BLACK,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    RegularTextReg("${job.language}", 18.0, BLACK, BALOO),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 7.0),
                                alignment: Alignment.centerLeft,
                                child: RegularTextMed("Applicants", 24.0, BLACK, BALOO)
                            ),
                            SizedBox(width: 10.0,),
                            RegularTextReg("\( ${applicantList.length} \)", 22.0, BLACK, BALOO)
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: applicantList.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                child: Container(
                                  height: 100.0,
                                  child: applicantListTile(context, index, applicantList[index]),
                                ),
                              );
                            },
                          ),
                        )
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