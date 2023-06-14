import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/profile_controller.dart';
import 'package:final_project_workconnect/functions/checkUidExists.dart';
import 'package:final_project_workconnect/functions/getAsync.dart';
import 'package:final_project_workconnect/functions/getListOfUsers.dart';
import 'package:final_project_workconnect/functions/pickImage.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:final_project_workconnect/view/screens/user/edit_profile_screen.dart';
import 'package:final_project_workconnect/view/screens/user/photo_view_screen.dart';
import 'package:final_project_workconnect/view/widgets/descriptionTextWidget.dart';
import 'package:final_project_workconnect/view/widgets/experienceWidget.dart';
import 'package:final_project_workconnect/view/widgets/jobExperienceWidget.dart';
import 'package:final_project_workconnect/view/widgets/skillsWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileScreen extends StatefulWidget {
  String? uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  String color = '';
  bool data = false;
  bool isUser = false;
  bool isFollowing = false;
  bool isRecommended = false;
  var userData;
  List recommend = [];
  bool uidExists = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.uid != '') {
      data = true;
      isUser = true;
      uid = widget.uid;
    }

    profileController.updateUserId(uid);
    getUserData();
    getIsFollowing();
    getIsRecommended();
    colorData();
    checkIfUidExists(FirebaseAuth.instance.currentUser!.uid);
  }

  bool isLoading = false;
  var imageFile;

  getIsFollowing() async {
    var data =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    List followers = data.data()!['followers'];

    if (followers.contains(FirebaseAuth.instance.currentUser!.uid)) {
      setState(() {
        isFollowing = true;
      });
    }
  }

  checkIfUidExists(String uid) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();
      print(snapshot.docs);
      setState(() {
        uidExists = snapshot.docs.isNotEmpty;
      });
    } catch (error) {
      // Handle the error appropriately
      print('Error checking UID existence: $error');
      setState(() {
        uidExists = false;
      });
    }
  }

  getIsRecommended() async {
    // var userData = await authController.getUserData();
    var data =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    recommend = data.data()!['recommendation'];

    if (recommend.contains(FirebaseAuth.instance.currentUser!.uid)) {
      setState(() {
        isRecommended = true;
      });
    }
  }

  void getUserData() async {
    userData = await authController.getUserData();
  }

  void colorData() async {
    color = await authController.getColorData(uid!);
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
      profileController.uploadImage(File(imageFile!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? _file;
    print(uidExists);

    return GetBuilder<ProfileController>(
        builder: (controller) => controller.user.isEmpty
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
                        color: controller.user['color'] == ''
                            ? Colors.red[600]
                            : toColor(controller.user['color']),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                      : Text(''),
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
                                                      : Text(''),
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          PhotoViewScreen(
                                                              image: controller
                                                                      .user[
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
                                    controller.user['username'],
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
                                    controller.user['jobCategory'],
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
                                        "${controller.user['city']}, ${controller.user['country']}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey[100],
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  !isUser
                                      ? InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => EditProfileScreen(),
                                            );
                                          },
                                          child: Icon(Icons.settings,
                                              size: 16,
                                              color: Colors.blueGrey[100]))
                                      : FirebaseAuth
                                                  .instance.currentUser!.uid ==
                                              uid
                                          ? Text('')
                                          : InkWell(
                                              onTap: () async {
                                                var snap =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(uid)
                                                        .get();

                                                List recommendation =
                                                    (snap.data()! as dynamic)[
                                                        'recommendation'];

                                                if (recommendation.contains(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid)) {
                                                  try {
                                                    await FirebaseFirestore
                                                        .instance
                                                      ..collection('users')
                                                          .doc(uid)
                                                          .update({
                                                        'recommendation':
                                                            FieldValue
                                                                .arrayRemove([
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                        ])
                                                      });
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                } else {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(uid)
                                                      .update({
                                                    "recommendation":
                                                        FieldValue.arrayUnion([
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                    ])
                                                  });
                                                  setState(() {
                                                    isRecommended =
                                                        !isRecommended;
                                                  });
                                                }
                                              },
                                              child: isRecommended
                                                  ? Text(
                                                      'Remove Recommendation',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ))
                                                  : Text('Recommend this user',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                            ),
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
                                      controller.user['followers'].isEmpty
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
                                                  .user['followers'].length
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blueGrey[100],
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
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
                                                ..collection('users')
                                                    .doc(uid)
                                                    .update({
                                                  'followers':
                                                      FieldValue.arrayRemove([
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
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
                                                  .collection('users')
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
                                          child: uidExists
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                )
                                              : Text(''),
                                        )
                                      : Text(''),
                                ])),

                            // const SizedBox(width: 100),
                            !isUser
                                ? InkWell(
                                    onTap: () =>
                                        {FirebaseAuth.instance.signOut()},
                                    child: Icon(
                                      Icons.logout_outlined,
                                      color: Colors.blueGrey[100],
                                    ),
                                  )
                                : SizedBox(width: 10),
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
                                    "About me",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: iconBool
                                            ? Colors.grey[200]
                                            : Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  DescriptionTextWidget(
                                    text: controller.user['jobDesc'] == ""
                                        ? 'No user description yet'
                                        : controller.user['jobDesc'],
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Text("Skills",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: iconBool
                                              ? Colors.grey[200]
                                              : Colors.black)),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    height: 40,
                                    width: 500,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        skillsWidget(
                                          uid: uid,
                                        ),
                                      ],
                                    ),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text("Experience",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: iconBool
                                              ? Colors.grey[200]
                                              : Colors.black)),
                                ),
                                const SizedBox(height: 10),
                                data
                                    ? Text('')
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            ExperienceWidget(uid: uid),
                                          ],
                                        ),
                                      ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [JobExperienceWidget(uid: uid)],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text("Recommendations",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: iconBool
                                              ? Colors.grey[200]
                                              : Colors.black)),
                                ),
                                const SizedBox(height: 10),
                                recommend.isNotEmpty
                                    ? StreamBuilder(
                                        stream: getUsersData(recommend),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          // print(snapshot.data[0].data());
                                          List recommendData = snapshot.data;

                                          // return Container();
                                          return Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: recommendData.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var item =
                                                      recommendData[index]
                                                          .data();
                                                  print(item);
                                                  String title =
                                                      item['username'] != null
                                                          ? item['username']
                                                          : item['orgName'];
                                                  String image =
                                                      item['profilePhoto'];

                                                  return ListTile(
                                                    leading: Image.network(
                                                      image,
                                                      width:
                                                          48, // Adjust the width as needed
                                                      height:
                                                          48, // Adjust the height as needed
                                                    ),
                                                    title: Text(title),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        })
                                    : Center(
                                        child: Text(
                                            'No Recommendations in profile'))
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
        stream:
            FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
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
