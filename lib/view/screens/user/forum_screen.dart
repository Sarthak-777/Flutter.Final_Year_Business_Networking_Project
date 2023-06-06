import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/post_controller.dart';
import 'package:final_project_workconnect/model/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final TextEditingController descriptionController = TextEditingController();

  PostController postController = Get.put(PostController());
  AuthController authController = Get.put(AuthController());

  void forumPostButton(String uid, String description, String username,
      String profilePic, String color) async {
    String res = 'Some Error Occured';
    try {
      String postId = Uuid().v1();

      Post post = Post(
          datePosted: DateTime.now(),
          description: description,
          username: username,
          likes: [],
          postId: postId,
          postUrl: '',
          uid: uid,
          type: 'forum',
          profilePic: profilePic,
          color: color);

      await FirebaseFirestore.instance.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
      Get.snackbar(res, 'forum creation success');

      // await FirebaseFirestore.instance.collection('posts').doc(uid).
    } catch (e) {
      res = e.toString();
      Get.snackbar(res, "forum creation fail. Please try again");
    }
  }

  void businessForumPostButton(
      String uid, String description, String orgName, String profilePic) async {
    String res = 'Some Error Occured';
    try {
      String postId = Uuid().v1();

      Post post = Post(
          datePosted: DateTime.now(),
          description: description,
          username: orgName,
          likes: [],
          postId: postId,
          postUrl: '',
          uid: uid,
          type: 'forum',
          profilePic: profilePic,
          color: '#424242');

      await FirebaseFirestore.instance.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
      Get.snackbar(res, 'forum creation success');
    } catch (e) {
      res = e.toString();
      Get.snackbar(res, "forum creation fail. Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a Post'),
        ),
        body: FutureBuilder(
          future: FirebaseAuth.instance.currentUser!.displayName == 'job-seeker'
              ? authController.getUserData()
              : authController.getBusinessData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print(snapshot.data);
              var user = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user['profilePhoto']),
                          radius: 20,
                        ),
                        user['username'] == null
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('${user['orgName']}'),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('${user['username']}'),
                              ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          hintText: 'Enter your description',
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 20.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: IconButton(
                        alignment: Alignment.bottomRight,
                        onPressed: () => user['username'] == null
                            ? businessForumPostButton(
                                user['uid'],
                                descriptionController.text,
                                user['orgName'],
                                user['profilePhoto'])
                            : forumPostButton(
                                user['uid'],
                                descriptionController.text,
                                user['username'],
                                user['profilePhoto'],
                                user['color']),
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
