import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/profile_controller.dart';
import 'package:final_project_workconnect/functions/getAsync.dart';
import 'package:final_project_workconnect/functions/pickImage.dart';
import 'package:final_project_workconnect/view/widgets/descriptionTextWidget.dart';
import 'package:final_project_workconnect/view/widgets/experienceWidget.dart';
import 'package:final_project_workconnect/view/widgets/skillsWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  String? uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(profileController.user['username']);
    var user = profileController.user;

    Uint8List? _file;

    return GetBuilder<ProfileController>(
      builder: (controller) => controller.user.isEmpty
          ? CircularProgressIndicator()
          : Scaffold(
              backgroundColor: Colors.blueGrey[50],
              appBar: AppBar(
                backgroundColor: Colors.blueGrey[900],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                    top: Radius.circular(30),
                  ),
                ),
                toolbarHeight: 220,
                flexibleSpace: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 160,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        var file =
                                            await pickImage(ImageSource.camera);
                                        if (file != null) {
                                          setState(() {
                                            _file = file;
                                          });
                                          profileController.uploadImage(file!);
                                        }
                                      },
                                      child: Text(
                                        "Upload from Camera,",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: TextButton.styleFrom(
                                          textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      )),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        var file = await pickImage(
                                            ImageSource.gallery);
                                        if (file != null) {
                                          setState(() {
                                            _file = file;
                                          });
                                          profileController.uploadImage(file!);
                                        }
                                      },
                                      child: Text(
                                        "Upload from Gallery,",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: TextButton.styleFrom(
                                          textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      )),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "X Cancel",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      style: TextButton.styleFrom(
                                          textStyle: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              print(snapshot.data);
                              return Image.network(
                                  snapshot.data.data()['profilePhoto']);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "username",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey[100],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey[100],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: mainColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey[100],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Icon(Icons.settings, size: 16, color: Colors.blueGrey[100])
                  ],
                )),
              ),
              body: SingleChildScrollView(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About me",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            DescriptionTextWidget(
                              text:
                                  "lorem ipush asdlkjasdlksadjasl aklsdjaslkdj aslkdj aslkdjsadlk j aslkjdaslkjdaslkdjaslkdja asdlkjaslkdj asl kjasdlk jasldk jasdkljasd",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: const Text(
                              "Skills",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            width: 500,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                skillsWidget(),
                                skillsWidget(),
                                skillsWidget(),
                                skillsWidget(),
                                skillsWidget(),
                                skillsWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "Experience",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                ExperienceWidget(),
                                ExperienceWidget(
                                    companyImage: 'assets/google-icon.png',
                                    companyName: 'Google',
                                    date: '2021 - 2022',
                                    title: 'UI/UX Developer'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ),
    );
  }
}
