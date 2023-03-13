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

List<Widget> homeScreenItems = [
  const Center(child: Text('Home')),
  const Center(child: Text('Search')),
  const Center(child: Text('Post')),
  const Center(child: Text('Jobs')),
  const Center(child: Text('Profile')),
];

bool iconBool = false;
IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.blueGrey[100],
    secondary: Colors.blueGrey,
  ),

  primaryColorDark: Colors.black,
  canvasColor: Colors.white,
  // brightness: Brightness.light,
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
