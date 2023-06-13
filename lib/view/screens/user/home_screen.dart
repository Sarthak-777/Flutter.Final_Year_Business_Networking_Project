// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/controller/theme_controller.dart';
import 'package:final_project_workconnect/model/FirebaseHelper.dart';
import 'package:final_project_workconnect/view/screens/user/nofifications_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/model/user.dart';
import 'package:final_project_workconnect/view/screens/user/chat_screen.dart';
import 'package:final_project_workconnect/view/widgets/feedCard.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());
  User? currentUser;
  MyUser? thisUserModel;
  ThemeController themeController = Get.put(ThemeController());

  getUserInfo() async {
    currentUser = FirebaseAuth.instance.currentUser;
    thisUserModel = await FirebaseHelper.getUserModelById(currentUser!.uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var stream = FirebaseFirestore.instance.collection('posts').snapshots();
  @override
  Widget build(BuildContext context) {
    getUserInfo();

    return FutureBuilder(
        future: authController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(
              "WorkConnect",
              style: GoogleFonts.roboto(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            var userData = snapshot.data as Map;

            return Container(
              color: iconBool ? Colors.black : Colors.grey[200],
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "WorkConnect",
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: iconBool ? Colors.white : Colors.black,
                          ),
                        ),
                        Row(children: [
                          IconButton(
                            color: iconBool ? Colors.white : kPrimaryColor,
                            onPressed: () {
                              Get.to(() => NotificationScreen(
                                  uid: FirebaseAuth.instance.currentUser!.uid));
                            },
                            icon: Icon(Icons.notifications_on),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ChatScreen(
                                    userModel: thisUserModel,
                                    firebaseUser: currentUser,
                                  ));
                            },
                            child: CircleAvatar(
                              backgroundColor: iconBool
                                  ? Colors.grey[800]
                                  : Colors.grey.shade200,
                              radius: 20,
                              child: Icon(
                                Icons.message,
                                color: iconBool
                                    ? Colors.grey[100]
                                    : Colors.blueGrey[800],
                                size: 20.0,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        userData['following'].isEmpty
                            ? Text('')
                            : InkWell(
                                onTap: () async {
                                  setState(() {
                                    stream = FirebaseFirestore.instance
                                        .collection('posts')
                                        .where("uid",
                                            whereIn: userData['following'])
                                        .snapshots();
                                  });
                                },
                                child: Text('Following')),
                        InkWell(
                            onTap: () async {
                              setState(() {
                                stream = FirebaseFirestore.instance
                                    .collection('posts')
                                    .snapshots();
                              });
                            },
                            child: Text('All Posts')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: StreamBuilder(
                            stream: stream != null
                                ? stream
                                : FirebaseFirestore.instance
                                    .collection('posts')
                                    .where("uid",
                                        whereIn: userData['following'])
                                    .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading...");
                              }

                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 10),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) => FeedCard(
                                      snap: snapshot.data.docs[index].data()),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
