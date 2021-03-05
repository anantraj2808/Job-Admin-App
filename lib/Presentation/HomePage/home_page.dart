import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/Presentation/ApplicantDetailsPage/applicant_details_page.dart';
import 'package:job_admin_app/Presentation/HomePage/Widgets/job_list_card.dart';
import 'package:job_admin_app/Presentation/JobDetailsPage/Widget/applicant_tile.dart';
import 'package:job_admin_app/Presentation/JobDetailsPage/job_details_page.dart';
import 'package:job_admin_app/Presentation/JobListingPage/View/job_listing_page.dart';
import 'package:job_admin_app/Presentation/SplashScreen/splash_screen.dart';
import 'package:job_admin_app/Presentation/post_a_job_form.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/WidgetsAndStyles/transitions.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/models/applicant.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:job_admin_app/services/get_created_jobs.dart';
import 'package:job_admin_app/services/search_workers.dart';
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
  bool isViewAllEnabled = true;
  List<Job> createdJobList = [];
  List<Job> filteredJobList = [];
  List<Applicant> workersList = [];
  bool isLoading = false;
  bool settingDetails = false;
  String _selectedState = statesList[0];
  List<String> citiesList = [];
  String _selectedCity = "Select a city";
  String _selectedProfession = "Select a Profession";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    widget.fromHome ? setUserDetailsRequest() : getCreatedJobsRequest(context);
    //filterActiveJobs();
  }

  filterActiveJobs(){
    filteredJobList.clear();
    if (createdJobList.length <= 3){
      setState(() {
        filteredJobList = createdJobList;
        isViewAllEnabled = false;
      });
      return;
    }

    for (int i=0 ; i<createdJobList.length ; i++){
      if (createdJobList[i].isActive == "true"){
        filteredJobList.add(createdJobList[i]);
      }
      if (filteredJobList.length == 3) break;
    }
    print("Filtered Job list length = ${filteredJobList.length}");
    filteredJobList = filteredJobList.toSet().toList();
    setState(() {
    });

  }

  setUserDetailsRequest() async {
    setState(() {
      isLoading = true;
      settingDetails = true;
    });
    String jwt = await SharedPrefs().getUserJWTSharedPrefs();
    await setUserDetails(context, jwt).then((val){
      if(val) getCreatedJobsRequest(context);
    });
    setState(() {
      settingDetails = false;
    });
  }

  Future<void> getCreatedJobsRequest(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await getCreatedJobs(context).then((val){
      setState(() {
        createdJobList = val;
        print("Created Job list length = ${createdJobList.length}");
      });
    });
    filterActiveJobs();
    setState(() {
      isLoading = false;
    });
  }

  initiateSearch() async {
    if (_selectedState == "Select a state" && _selectedCity == "Select a city" && _selectedProfession == "Select a Profession") toast("Please select location and/or profession");
    if (_selectedState != "Select a state" && _selectedCity == "Select a city") toast("Please select a city");
    else{
      setState(() {
        isLoading = true;
      });
      await searchWorkers(_selectedProfession, _selectedCity, _selectedState).then((val){
        setState(() {
          print("Length = " + val.length.toString());
          workersList = val;
          isLoading = false;
        });
      });
    }
  }

  toast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: THEME_MID_BLUE,
        textColor: WHITE,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Admin userProvider = Provider.of<Admin>(context);
    return !(isLoading && settingDetails) ?  Scaffold(
      appBar: AppBar(
        backgroundColor: THEME_DARK_BLUE,
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
            preferredSize: Size.fromHeight(140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 12.0,bottom: 15.0),
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.0)
                          ),
                          child:DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              value: _selectedState,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedState = newValue;
                                  _selectedCity = "Select a city";
                                  if(_selectedState == statesList[1]) citiesList = gujaratCities;
                                  if(_selectedState == statesList[2]) citiesList = maharashtraCities;
                                  if(_selectedState == statesList[3]) citiesList = mpCities;
                                  if(_selectedState == statesList[4]) citiesList = punjabCities;
                                  if(_selectedState == statesList[5]) citiesList = rajasthanCities;
                                  if(_selectedState == statesList[6]) citiesList = upCities;
                                  _selectedCity = citiesList[0];
                                });
                              },
                              items: statesList.map((location) {
                                return DropdownMenuItem(
                                  child: Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          )
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 12.0,bottom: 15.0),
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.0)
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Select a city'),
                              value: _selectedCity,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCity = newValue;
                                });
                              },
                              items: citiesList.map((city) {
                                return DropdownMenuItem(
                                  child: new Text(city),
                                  value: city,
                                );
                              }).toList(),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 12.0,bottom: 15.0),
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.0)
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Select a Profession'),
                              value: _selectedProfession,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedProfession = newValue;
                                });
                              },
                              items: PROFESSION_LIST.map((city) {
                                return DropdownMenuItem(
                                  child: new Text(city),
                                  value: city,
                                );
                              }).toList(),
                            ),
                          )
                      ),
                    ),
                    Container(
                      width: 80.0,
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: IconButton(
                        icon: Icon(Icons.search,color: Colors.white,),
                        onPressed: (){
                          setState(() {
                            isSearchInitiated = true;
                          });
                          initiateSearch();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ) : PreferredSize(preferredSize: Size.fromHeight(0.0),
              child: Container())
      ),
      body: !isSearchInitiated ? Stack(
        children: [
          if (isLoading && settingDetails) SplashScreen(),
          if (isLoading && !settingDetails) loader(context),
          Opacity(
            opacity: isLoading ? 0.0 : 1.0,
            child: SafeArea(
              child: filteredJobList.length != 0 ? Center(
                child: Column(
                  children: [
                    filteredJobList.length != 0 ? Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 12.0,right: 12.0,top: 8.0),
                      child: RegularTextMed("Jobs you\'ve created \:", 22.0, THEME_DARK_BLUE, BALOO),
                    ) : Container(),
                    filteredJobList.length != 0 ? Container(
                      height: 180.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: isViewAllEnabled ? filteredJobList.toSet().toList().length+1 : filteredJobList.toSet().toList().length,
                        itemBuilder: (context,index){
                          if (index == filteredJobList.length){
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(createRoute(JobListingPage(createdJobsList: createdJobList,)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0,bottom: 20.0,left: 12.0,right: 12.0),
                                width: 200.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: THEME_DARK_BLUE),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RegularTextMed("VIEW ALL", 20.0, THEME_DARK_BLUE, BALOO),
                                ),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => JobDetailsPage(job: filteredJobList[index],)
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 12.0,right: 12.0,top: 10.0,bottom: 20.0),
                              height: 150.0,
                              width: 200.0,
                              child: jobLListCard(filteredJobList[index], context, index),
                            ),
                          );
                        },
                      ),
                    ) : Container()
                  ],
                ),
              ) : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/no_job.png'),
                    ),
                    SizedBox(height: 20.0,),
                    RegularTextMed("No Jobs created yet", 24.0, THEME_DARK_BLUE, BALOO)
                  ],
                ),
              ),
            ),
          )
        ],
      ) :
      Stack(
        children: [
          if (isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.0 : 1.0,
            child: SafeArea(
              child: workersList.length != 0 ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: workersList.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ApplicantDetailsPage(applicant: workersList[index],isApplicant: false,)
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        height: 100.0,
                        child: applicantListTile(context, index, workersList[index]),
                      ),
                    );
                  },
                ),
              ) : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/no_worker.png'),
                    ),
                    SizedBox(height: 20.0,),
                    RegularTextMed("No suitable worker found", 24.0, THEME_DARK_BLUE, BALOO)
                  ],
                ),
              ),
            ),
          )
        ],
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
            color: THEME_BLACK_BLUE,
            borderRadius: BorderRadius.circular(ht*0.013)
          ),
          child: Center(child: RegularTextMedCenter("Post a Job", ht*0.027, WHITE, BALOO)),
        ),
      ),
    ) : SplashScreen();
  }
}
