import 'package:flutter/material.dart';
import 'package:job_seek/TabItems/Add_Jobs.dart';
import 'package:job_seek/TabItems/profilepage.dart';
import 'package:job_seek/TabItems/searchbar.dart';
import 'package:job_seek/TabItems/view_jobs.dart';
import 'package:job_seek/bottomNavigation/animated_bottom_bar.dart';
import 'package:job_seek/root_page.dart';

import '../authe.dart';

class bottom_bar extends StatefulWidget {
  bottom_bar({this.auth});
  final BaseAuth auth;
  
  final List<BarItem> barItems = [
    BarItem(
      text: 'Category',
      iconData: Icons.home,
      color: Colors.indigo,
    ),
    BarItem(
      text: 'Review',
      iconData: Icons.home,
      color: Colors.pinkAccent,
    ),
    BarItem(
      text: 'search',
      iconData: Icons.search,
      color: Colors.yellow.shade900,
    ),
    BarItem(
      text: 'Profile',
      iconData: Icons.person_outline,
      color: Colors.teal,
    ),
  ];

  @override
  _bottom_barState createState() => _bottom_barState();
}

class _bottom_barState extends State<bottom_bar> {
  

  int selectedBarIndex = 0;

  final widgetOptions = [
    ViewJobDetails(),
    AddJobDetails(),
    SearchScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedBarIndex),
      ),
      drawer: AnimatedContainer(
        color: widget.barItems[selectedBarIndex].color,
        duration: const Duration(milliseconds: 500),
      ),
      bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          barStyle: BarStyle(
            fontSize: 14.0,
            iconSize: 22.0,
          ),
          animationDuration: const Duration(milliseconds: 150),
          onBarTap: (index) {
            setState(() {
              selectedBarIndex = index;
            });
          }),
    );
  }
}
