import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_admin_app/Presentation/HomePage/Widgets/job_list_card.dart';
import 'package:job_admin_app/Presentation/post_a_job_form.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/WidgetsAndStyles/transitions.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:job_admin_app/services/get_created_jobs.dart';
import 'package:job_admin_app/services/set_details.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  final bool fromHome;
  HomePage({this.fromHome});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isSearchEnabled = false;
  bool isSearchInitiated = false;
  List<Job> createdJobList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.fromHome ? setUserDetailsRequest() : getCreatedJobsRequest(context);
    //filterActiveJobs();
  }

  filterActiveJobs(){

  }

  setUserDetailsRequest() async {
    setState(() {
      isLoading = true;
    });
    String jwt = await SharedPrefs().getUserJWTSharedPrefs();
    await setUserDetails(context, jwt).then((val){
      if(val) getCreatedJobsRequest(context);
    });
    setState(() {
      isLoading = false;
    });
  }

  getCreatedJobsRequest(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await getCreatedJobs(context).then((val){
      setState(() {
        createdJobList = val;
        print("Created JOb list length = ${createdJobList.length}");
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Admin userProvider = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BLACK,
        title: Text("Job Admin App"),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: ht*0.02),
            child: IconButton(
              onPressed: (){
                setState(() {
                  print("UID = " + userProvider.uid.toString());
                  if (isSearchInitiated) isSearchInitiated = false;
                  isSearchEnabled = !isSearchEnabled;
                });
              },
              icon: Icon(isSearchEnabled ? Icons.keyboard_arrow_up : Icons.search_outlined, color: WHITE,),
            ))
        ],
          bottom: isSearchEnabled ?  PreferredSize(
            preferredSize: Size.fromHeight(ht*0.091),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 12.0,bottom: 15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0)
                    ),
                    child: TextFormField(
                      onChanged: (String text){
                      },
                      //controller: _searchController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: "Search for a person",
                          contentPadding: const EdgeInsets.only(left: 24.0),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: IconButton(
                    icon: Icon(Icons.search,color: Colors.white,),
                    onPressed: (){
                      setState(() {
                        isSearchInitiated = true;
                      });
                    },
                  ),
                )
              ],
            ),
          ) : PreferredSize(preferredSize: Size.fromHeight(0.0),
              child: Container())
      ),
      body: !isSearchInitiated ? Stack(
        children: [
          if (isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    createdJobList.length != 0 ? Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 12.0,right: 12.0,top: 8.0),
                      child: RegularTextMed("Jobs you\'ve created \:", 22.0, BLACK, BALOO),
                    ) : Container(),
                    createdJobList.length != 0 ? Container(
                      height: 180.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: createdJobList.length+1,
                        itemBuilder: (context,index){
                          if (index == createdJobList.length){
                            return Container(
                              margin: EdgeInsets.only(top: 10.0,bottom: 20.0,left: 12.0,right: 12.0),
                              width: 200.0,
                              decoration: BoxDecoration(
                                  border: Border.all(color: BLACK),
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: RegularTextMed("VIEW ALL", 20.0, BLACK, BALOO),
                              ),
                            );
                          }
                          return Container(
                            margin: EdgeInsets.only(left: 12.0,right: 12.0,top: 10.0,bottom: 20.0),
                            height: 150.0,
                            width: 200.0,
                            child: jobLListCard(createdJobList[index], context, index),
                          );
                        },
                      ),
                    ) : Container()
                  ],
                ),
              ),
            ),
          )
        ],
      ) : Container(height: 100.0,width: 100.0,color: RED,),
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
