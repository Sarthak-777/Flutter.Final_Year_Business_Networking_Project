import 'package:final_project_workconnect/view/screens/business/business_home_screen.dart';
import 'package:final_project_workconnect/view/screens/business/business_job_posting_screen.dart';

import 'package:final_project_workconnect/view/screens/business/business_job_screen.dart';
import 'package:final_project_workconnect/view/screens/business/business_profile_screen.dart';
import 'package:final_project_workconnect/view/screens/user/home_screen.dart';
import 'package:final_project_workconnect/view/screens/user/jobs_screen.dart';
import 'package:final_project_workconnect/view/screens/user/post_screen.dart';
import 'package:final_project_workconnect/view/screens/user/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var color = Colors.blue;

List<String> working = ['Yes', 'No'];

List<String> category = [
  'Developer',
  'Business Analyst',
  'Teacher',
  'Marketer',
  'Student'
];

List<String> jobTime = [
  'Full-time',
  'Part-time',
];

List<String> jobType = [
  'Remote',
  'Physical',
];

List themeData = ['red', 'blue', 'green', 'black'];
var mainColor = Colors.blueGrey[100];

const kPrimaryColor = Colors.blueGrey;

class TabBarClass {
  List<Tab> tabBarFunc([int? page]) {
    return <Tab>[
      Tab(
        icon: Icon(
          page == 0 ? Icons.home : Icons.home_outlined,
          color: iconBool ? Colors.white : kPrimaryColor,
        ),
      ),
      Tab(
        icon: Icon(
          page == 1 ? Icons.search : Icons.search_outlined,
          color: iconBool ? Colors.white : kPrimaryColor,
        ),
      ),
      Tab(
        icon: Icon(
          page == 2 ? Icons.add : Icons.add_outlined,
          color: iconBool ? Colors.white : kPrimaryColor,
        ),
      ),
      Tab(
        icon: Icon(
          page == 3 ? Icons.work_history : Icons.work_history_outlined,
          color: iconBool ? Colors.white : kPrimaryColor,
        ),
      ),

      Tab(
        child: CircleAvatar(
          radius: 14,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1656098996938-10e80c66d668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
        ),
      ),
      //  Tab(
      //   icon: Icon(
      //     Icons.,
      //     color: Colors.grey[300],
      //   ),
      // ),
    ];
  }
}

const kBgMainColor = Color.fromARGB(255, 255, 241, 246);

List<Widget> homeScreenItems = [
  HomeScreen(),
  Text('Search'),
  PostScreen(),
  JobsScreen(),
  ProfileScreen(uid: ''),
];

List<Widget> businessScreenItems = [
  BusinessHomeScreen(),
  JobPostingScreen(),
  PostScreen(),
  BusinessJobScreen(),
  BusinessProfileScreen(uid: ''),
];

bool iconBool = false;
IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;
ThemeData lightTheme = ThemeData(
  primaryColor: Colors.grey[100],
  primaryColorLight: Colors.grey[100],
  primaryColorDark: Colors.black,
  brightness: Brightness.light,
  canvasColor: Colors.grey[200],
  indicatorColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey[900],
  ),
);

ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    primaryColorLight: Colors.black,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black,
    indicatorColor: Colors.white,
    canvasColor: Colors.black,

    // next line is important!
    appBarTheme: AppBarTheme(brightness: Brightness.dark));

List<String> JobIndustry = [
  'Advertising Agency',
  'Architecture',
  'Banks',
  'Insurance',
  'Technology',
  'E-Commerce',
  'Information/Compute/Technology',
  'Clinic/Hospital',
  'ISP',
  'Teaching Industry',
  'Repair Services',
  'Software Companies'
];
