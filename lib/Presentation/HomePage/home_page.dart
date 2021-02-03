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

  bool isSearchEnabled = false;
  bool isSearchInitiated = false;

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
      appBar: AppBar(
        backgroundColor: BLACK,
        title: Text("Job Admin App"),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: ht*0.02),
            child: IconButton(
              onPressed: (){
                setState(() {
                  if (isSearchInitiated) isSearchInitiated = false;
                  isSearchEnabled = !isSearchEnabled;
                });
              },
              icon: Icon(isSearchEnabled ? Icons.keyboard_arrow_up : Icons.search_outlined, color: WHITE,),
            ))
        ],
          bottom: isSearchEnabled ?  PreferredSize(
            preferredSize: Size.fromHeight(70.0),
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
      body: !isSearchInitiated ? SafeArea(
        child: Center(
          child: Column(
            children: [
            ],
          ),
        ),
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
