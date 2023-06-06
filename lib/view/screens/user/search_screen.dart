import 'package:final_project_workconnect/controller/search_controller.dart'
    as controller;
import 'package:final_project_workconnect/view/screens/business/auth/business_register_screen.dart';
import 'package:final_project_workconnect/view/screens/business/business_profile_screen.dart';
import 'package:final_project_workconnect/view/screens/user/job_description_screen.dart';
import 'package:final_project_workconnect/view/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  controller.SearchController searchController =
      Get.put(controller.SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Search",
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: InkWell(
                onTap: () {
                  searchController.searchFirebaseData(_searchController.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Search',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Users",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => searchController.searchData.isEmpty
                ? Center(child: Text("Not Found"))
                : Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: searchController.searchData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(searchController.searchData[index].data());
                              Get.to(() => ProfileScreen(
                                  uid: searchController.searchData[index]
                                      .data()['uid']));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: Image.network(searchController
                                        .searchData[index]
                                        .data()['profilePhoto'])
                                    .image,
                              ),
                              title: Text(searchController.searchData[index]
                                  .data()['username']),
                            ),
                          );
                        }),
                  )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Business",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => searchController.companyData.isEmpty
                ? Center(child: Text("Not Found"))
                : Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: searchController.companyData.length,
                        itemBuilder: (context, index) {
                          print(searchController.companyData[index]
                              .data()['profilePhoto']);
                          return InkWell(
                            onTap: () {
                              Get.to(() => BusinessProfileScreen(
                                  uid: searchController.companyData[index]
                                      .data()['uid']));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: Image.network(searchController
                                        .companyData[index]
                                        .data()['profilePhoto'])
                                    .image,
                              ),
                              title: Text(searchController.companyData[index]
                                  .data()['orgName']),
                            ),
                          );
                        }),
                  )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Jobs",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => searchController.jobData.isEmpty
                ? Center(child: Text("Not Found"))
                : Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: searchController.jobData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => JobDescriptionScreen(
                                  data: searchController.jobData[index].data(),
                                  color: authController.userData['color']));
                            },
                            child: ListTile(
                              title: Text(
                                '${searchController.jobData[index].data()['jobTitle']}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "${searchController.jobData[index].data()['username']}\n${searchController.jobData[index].data()['jobTime']}    ${searchController.jobData[index].data()['jobType']}\n\n${searchController.jobData[index].data()['jobDesc']}",
                                style: TextStyle(),
                              ),
                            ),
                          );
                        }),
                  ))
          ],
        ),
      ),
    ));
  }
}
