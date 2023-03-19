import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/functions/getUsername.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = '';
  int pageIdx = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameFunc();
  }

  void usernameFunc() async {
    String username = await getUsername();
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      //     AppBar(elevation: 0, backgroundColor: Colors.transparent, actions: [
      //   IconButton(
      //     color: iconBool ? Colors.white : kPrimaryColor,
      //     onPressed: () {
      //       setState(() {
      //         iconBool = !iconBool;
      //       });
      //       if (iconBool == true) {
      //         Get.changeTheme(darkTheme);
      //       } else {
      //         Get.changeTheme(lightTheme);
      //       }
      //     },
      //     icon: Icon(
      //       iconBool ? iconDark : iconLight,
      //     ),
      //   ),
      //   InkWell(
      //     onTap: () {},
      //     child: CircleAvatar(
      //       backgroundColor: Colors.grey.shade200,
      //       radius: 20,
      //       child: const Icon(
      //         Icons.message,
      //         color: kPrimaryColor,
      //         size: 25.0,
      //       ),
      //     ),
      //   ),
      //   const SizedBox(
      //     width: 8.0,
      //   ),
      // ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: iconBool ? Colors.blueGrey[800] : mainColor,
            onTap: (index) {
              setState(() {
                pageIdx = index;
              });
            },
            currentIndex: pageIdx,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  pageIdx == 0 ? Icons.home : Icons.home_outlined,
                  color: iconBool ? Colors.white : kPrimaryColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    pageIdx == 1 ? Icons.search : Icons.search_outlined,
                    color: iconBool ? Colors.white : kPrimaryColor,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                icon: Icon(
                  pageIdx == 2 ? Icons.add : Icons.add_outlined,
                  color: iconBool ? Colors.white : kPrimaryColor,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    pageIdx == 3
                        ? Icons.work_history
                        : Icons.work_history_outlined,
                    color: iconBool ? Colors.white : kPrimaryColor,
                  ),
                  label: 'Jobs'),
              BottomNavigationBarItem(
                icon: Icon(
                  pageIdx == 4 ? Icons.person : Icons.person_outline,
                  color: iconBool ? Colors.white : kPrimaryColor,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Center(child: homeScreenItems[pageIdx]),
    );
  }
}
