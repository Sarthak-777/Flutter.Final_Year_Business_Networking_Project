import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/theme_controller.dart';
import 'package:final_project_workconnect/functions/getUsername.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String _username = '';
  int pageIdx = 0;
  AuthController authController = Get.put(AuthController());
  ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // usernameFunc();
    // authController.getUserData();
    authController.getBusinessData();
  }

  void usernameFunc() async {
    String username = await getUsername();
    if (this.mounted) {
      setState(() {
        _username = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor:
              themeController.iconBool.value ? Colors.black : Colors.white,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
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
                backgroundColor: themeController.iconBool.value
                    ? Colors.blueGrey[800]
                    : mainColor,
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
                      color: themeController.iconBool.value
                          ? Colors.white
                          : kPrimaryColor,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        pageIdx == 1 ? Icons.search : Icons.search_outlined,
                        color: themeController.iconBool.value
                            ? Colors.white
                            : kPrimaryColor,
                      ),
                      label: 'Search'),
                  BottomNavigationBarItem(
                    icon: Icon(
                      pageIdx == 2 ? Icons.add : Icons.add_outlined,
                      color: themeController.iconBool.value
                          ? Colors.white
                          : kPrimaryColor,
                    ),
                    label: 'Post',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      pageIdx == 3
                          ? Icons.work_history
                          : Icons.work_history_outlined,
                      color: themeController.iconBool.value
                          ? Colors.white
                          : kPrimaryColor,
                    ),
                    label: 'Jobs',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      pageIdx == 4 ? Icons.person : Icons.person_outline,
                      color: themeController.iconBool.value
                          ? Colors.white
                          : kPrimaryColor,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
          body: Center(child: businessScreenItems[pageIdx]),
        ));
  }
}
