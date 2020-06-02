import 'package:flutter/material.dart';
import 'package:job_seek/TabItems/profilepicture.dart';
import 'package:job_seek/index_page.dart';
import 'package:job_seek/root_page.dart';
import 'TabItems/Add_Jobs.dart';
import 'TabItems/profilepage.dart';
import 'TabItems/searchbar.dart';
import 'TabItems/view_jobs.dart';
import 'authe.dart';
import 'AuthPage.dart';
import 'bottomNavigation/bottom_bar.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JobSeek Application',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        //RootPage(auth: new Authe())
        home: ProfilePage(),
        //RootPage(auth: new Authe(),),
        routes: <String, WidgetBuilder>{
          '/authpage': (BuildContext context) => AuthPage(),
          '/homepage': (BuildContext context) => bottom_bar(),
          '/selectpicture': (BuildContext context) => Profile(),
        });
  }
}
