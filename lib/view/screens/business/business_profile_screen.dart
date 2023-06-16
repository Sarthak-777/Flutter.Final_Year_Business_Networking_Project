import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/business/business_profile_controller.dart';
import 'package:final_project_workconnect/controller/profile_controller.dart';
import 'package:final_project_workconnect/functions/getAsync.dart';
import 'package:final_project_workconnect/functions/pickImage.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:final_project_workconnect/model/business.dart';
import 'package:final_project_workconnect/view/screens/business/business_customize_profile.dart';
import 'package:final_project_workconnect/view/screens/business/business_photo_view_screen.dart';
import 'package:final_project_workconnect/view/screens/user/edit_profile_screen.dart';
import 'package:final_project_workconnect/view/screens/user/photo_view_screen.dart';
import 'package:final_project_workconnect/view/widgets/descriptionTextWidget.dart';
import 'package:final_project_workconnect/view/widgets/experienceWidget.dart';
import 'package:final_project_workconnect/view/widgets/profileFeed.dart';
import 'package:final_project_workconnect/view/widgets/skillsWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class BusinessProfileScreen extends StatefulWidget {
  String? uid;
  BusinessProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final BusinessController businessController = Get.put(BusinessController());
  final AuthController authController = Get.put(AuthController());
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  String color = '';
  bool isUser = false;
  bool isFollowing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.uid != '') {
      uid = widget.uid;
      isUser = true;
    }
    businessController.updateBusinessId(uid);
    authController.getBusinessData();
    getIsFollowing();
  }

  bool isLoading = false;
  var imageFile;

  // void colorData() async {
  //   color = await authController.getColorData(uid!);
  // }

  getIsFollowing() async {
    var data =
        await FirebaseFirestore.instance.collection("business").doc(uid).get();
    List followers = data.data()!['followers'];
    if (followers.contains(FirebaseAuth.instance.currentUser!.uid)) {
      setState(() {
        isFollowing = true;
      });
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);

    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
      businessController.uploadImage(File(imageFile!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? _file;

    return GetBuilder<BusinessController>(
        builder: (controller) => controller.business.isEmpty
            ? CircularProgressIndicator()
            : Scaffold(
                backgroundColor:
                    iconBool ? Colors.grey[900] : Colors.blueGrey[50],
                body: SingleChildScrollView(
                  child: Column(children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: Container(
                        // backgroundColor:  Colors.red[900],
                        // shape: const RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.vertical(
                        //     bottom: Radius.circular(30),
                        //     top: Radius.circular(30),
                        //   ),
                        // ),
                        // actions: [

                        //   const SizedBox(width: 20),
                        // ],
                        // toolbarHeight: 220,

                        color: Colors.grey[600],
                        height: 300,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.chevron_left_outlined,
                                color: Colors.grey[200],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: InkWell(
                                      onTap: () {
                                        Get.bottomSheet(
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              height: 200,
                                              color: Colors.white,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  !isUser
                                                      ? TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            XFile? pickedFile =
                                                                await ImagePicker()
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.camera);
                                                            if (pickedFile !=
                                                                null) {
                                                              cropImage(
                                                                  pickedFile);
                                                            }
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Text(
                                                              "Upload from Camera,",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          style: TextButton
                                                              .styleFrom(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                        )
                                                      : Container(),
                                                  !isUser
                                                      ? TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            XFile? pickedFile =
                                                                await ImagePicker()
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                            if (pickedFile !=
                                                                null) {
                                                              cropImage(
                                                                  pickedFile);
                                                            }
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Text(
                                                              "Upload from Gallery,",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          style: TextButton
                                                              .styleFrom(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                        )
                                                      : Container(),
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          BusinessPhotoViewScreen(
                                                              image: controller
                                                                      .business[
                                                                  'profilePhoto'],
                                                              uid: uid));
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Text(
                                                        "View Image",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                        textStyle:
                                                            const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Text(
                                                        "X Cancel",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                        textStyle:
                                                            const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ProfilePictureWidget(uid: uid),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    controller.business['orgName'],
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
                                    controller.business['jobCategory'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueGrey[100],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Icon(
                                  //       Icons.people_alt_outlined,
                                  //       size: 12,
                                  //       color: mainColor,
                                  //     ),
                                  //     const SizedBox(width: 3),
                                  //     Text(
                                  //       "0 Employees in WorkConnect",
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //         color: Colors.blueGrey[100],
                                  //         fontWeight: FontWeight.w400,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(height: 5),
                                  !isUser
                                      ? InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => EditBusinessProfileScreen(),
                                            );
                                          },
                                          child: Icon(Icons.settings,
                                              size: 16,
                                              color: Colors.blueGrey[100]))
                                      : Text(''),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey[100],
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      controller.business['followers'].isEmpty
                                          ? Text(
                                              '0',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blueGrey[100],
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          : Text(
                                              controller
                                                  .business['followers'].length
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blueGrey[100],
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                    ],
                                  ),
                                  isUser
                                      ? InkWell(
                                          onTap: () async {
                                            var snap = await FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get();
                                            List following = (snap.data()!
                                                as dynamic)['following'];

                                            if (following.contains(uid)) {
                                              await FirebaseFirestore.instance
                                                  .collection('business')
                                                  .doc(uid)
                                                  .update({
                                                'followers':
                                                    FieldValue.arrayRemove([
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                                ])
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'following':
                                                    FieldValue.arrayRemove(
                                                        [uid])
                                              });
                                            } else {
                                              await FirebaseFirestore.instance
                                                  .collection('business')
                                                  .doc(uid)
                                                  .update({
                                                'followers':
                                                    FieldValue.arrayUnion([
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                                ])
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'following':
                                                    FieldValue.arrayUnion([uid])
                                              });
                                            }
                                            setState(() {
                                              isFollowing = !isFollowing;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: isFollowing
                                                ? Text(
                                                    'Unfollow',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                : Text(
                                                    'Follow',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                          ),
                                        )
                                      : Text(''),
                                ],
                              ),
                            ),
                            // const SizedBox(width: 100),
                            InkWell(
                              onTap: () => authController.signOut(),
                              child: Icon(
                                Icons.logout_outlined,
                                color: Colors.blueGrey[100],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About this Business",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: iconBool
                                            ? Colors.grey[200]
                                            : Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  DescriptionTextWidget(
                                    text: controller.business['jobDesc'] == ''
                                        ? 'No business description yet'
                                        : controller.business['jobDesc'],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: 30),
                            //       child: Text("Skills",
                            //           style: TextStyle(
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.w800,
                            //               color: iconBool
                            //                   ? Colors.grey[200]
                            //                   : Colors.black)),
                            //     ),
                            //     const SizedBox(height: 10),
                            //     Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(horizontal: 5),
                            //       child: SizedBox(
                            //         height: 40,
                            //         width: 500,
                            //         child: ListView(
                            //           scrollDirection: Axis.horizontal,
                            //           children: [
                            //             skillsWidget(
                            //               uid: uid,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text("",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: iconBool
                                              ? Colors.grey[200]
                                              : Colors.black)),
                                ),
                                // const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: iconBool
                                                ? Colors.grey[200]
                                                : Colors.black),
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('posts')
                                            .where(
                                              "uid",
                                              isEqualTo: uid,
                                            )
                                            .snapshots(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Text("Loading...");
                                          }
                                          if (snapshot.data.docs.isEmpty) {
                                            return Container(
                                                width: 500,
                                                child: Text("No Posts yet"));
                                          } else {
                                            return SizedBox(
                                              height: 500,
                                              width: 400,
                                              child: ListView.builder(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0),
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) =>
                                                    SizedBox(
                                                  width: 400,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: ProfileFeed(
                                                        snap: snapshot
                                                            .data.docs[index]
                                                            .data()),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                  ]),
                ),
              ));
  }
}

class ProfilePictureWidget extends StatelessWidget {
  String? uid;

  ProfilePictureWidget({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('business')
            .doc(uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Image.network(
            snapshot.data.data()['profilePhoto'],
            fit: BoxFit.fitWidth,
          );
        },
      ),
    );
  }
}
