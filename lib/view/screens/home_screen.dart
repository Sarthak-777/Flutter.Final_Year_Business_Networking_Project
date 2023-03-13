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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _username = '';
  TabController? _tabController;
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: TabBarClass().tabBarFunc().length,
        initialIndex: 0,
        vsync: this);
    pageController = PageController();
    usernameFunc();
  }

  void usernameFunc() async {
    String username = await getUsername();
    setState(() {
      _username = username;
    });
  }

  void navigationTap(page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    print(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello, $_username',
            style: TextStyle(color: iconBool ? Colors.white : kPrimaryColor),
          ),
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: iconBool ? Colors.white : kPrimaryColor,
            tabs: TabBarClass().tabBarFunc(_page),
            onTap: navigationTap,
          ),
          actions: [
            IconButton(
              color: iconBool ? Colors.white : kPrimaryColor,
              onPressed: () {
                setState(() {
                  iconBool = !iconBool;
                });
                if (iconBool == true) {
                  Get.changeTheme(darkTheme);
                } else {
                  Get.changeTheme(lightTheme);
                }
              },
              icon: Icon(
                iconBool ? iconDark : iconLight,
              ),
            ),
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 20,
                child: const Icon(
                  Icons.message,
                  color: kPrimaryColor,
                  size: 25.0,
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
          ],
        ),
        body: PageView(
          children: homeScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged,
        ));
  }
}
