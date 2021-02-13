import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/HomePage/home_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/services/get_created_jobs.dart';
import 'package:job_admin_app/services/set_details.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'models/admin.dart';
import 'models/job.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;

  List<Widget> _screens = [
    HomePage(fromHome: true,),
    Container()
  ];
  PageController _pageController = PageController();

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _screens,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text("Home", style: TextStyle(
                  color: _selectedIndex == 0 ? BLACK : GREY
              ),),
              icon: Icon(Icons.home,color: _selectedIndex == 0 ? BLACK : GREY,)),
          BottomNavigationBarItem(
              title: Text("Profile", style: TextStyle(
                  color: _selectedIndex == 1 ? BLACK : GREY
              ),),
              icon: Icon(Icons.person,color: _selectedIndex == 1 ? BLACK : GREY)),
          ],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
