import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/ApplicantDetailsPage/applicant_details_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/applicant.dart';

import 'Widget/applicant_tile.dart';

class SelectedProfilesPage extends StatefulWidget {

  final List<Applicant> acceptedList;
  final List<Applicant> inReviewList;

  SelectedProfilesPage({this.acceptedList,this.inReviewList});

  @override
  _SelectedProfilesPageState createState() => _SelectedProfilesPageState();
}

class _SelectedProfilesPageState extends State<SelectedProfilesPage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        backgroundColor: WHITE,
        title: Text("Selected Profiles",style: TextStyle(color: BLACK),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: BLACK,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          if(isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.acceptedList.length != 0 ? Row(
                        children: [
                          Container(
                            height : 10.0,
                            width : 10.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: GREEN
                            ),
                          ),
                          RegularTextMed("    Accepted", 24.0, BLACK, BALOO)
                        ],
                      ) : Container(),
                      widget.acceptedList.length != 0 ? SizedBox(height: 10.0,) : Container(),
                      widget.acceptedList.length != 0 ? Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.acceptedList.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context) => ApplicantDetailsPage(applicant: widget.acceptedList[index], isApplicant: true,)
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                height: 100.0,
                                child: applicantListTile(context, index, widget.acceptedList[index]),
                              ),
                            );
                          },
                        ),
                      ) : Container(),
                      SizedBox(height: 10.0,),
                      Divider(indent: 5.0,endIndent: 5.0,),
                      SizedBox(height: 10.0,),
                      widget.inReviewList.length != 0 ? Row(
                        children: [
                          Container(
                            height : 10.0,
                            width : 10.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: YELLOW
                            ),
                          ),
                          RegularTextMed("    In-Review", 24.0, BLACK, BALOO)
                        ],
                      ) : Container(),
                      widget.inReviewList.length != 0 ? SizedBox(height: 10.0,) : Container(),
                      widget.inReviewList.length != 0 ? Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.inReviewList.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context) => ApplicantDetailsPage(applicant: widget.inReviewList[index], isApplicant: true,)
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                height: 100.0,
                                child: applicantListTile(context, index, widget.inReviewList[index]),
                              ),
                            );
                          },
                        ),
                      ) : Container(),
                    ],
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
