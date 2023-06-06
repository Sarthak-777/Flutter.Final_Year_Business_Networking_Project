import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/post_controller.dart';
import 'package:final_project_workconnect/functions/pickImage.dart';
import 'package:final_project_workconnect/model/post.dart';
import 'package:final_project_workconnect/view/screens/user/forum_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController descriptionController = TextEditingController();
  PostController postController = Get.put(PostController());
  AuthController authController = Get.put(AuthController());
  Uint8List? _file;

  dialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                child: const Text('Take a picture'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Create a Forum'),
                onPressed: () async {
                  Navigator.of(context).pop();

                  Get.to(() => ForumScreen());
                },
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void postButton(String uid, Uint8List file, String description,
      String username, String profilePic, String color) async {
    String res = 'Some Error Occured';
    try {
      String fileUrl = await postController.storeImage(file, 'posts', true);
      print(profilePic);
      String postId = Uuid().v1();

      Post post = Post(
          datePosted: DateTime.now(),
          description: description,
          username: username,
          likes: [],
          postId: postId,
          postUrl: fileUrl,
          uid: uid,
          type: 'photo',
          profilePic: profilePic,
          color: color);

      await FirebaseFirestore.instance.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
      Get.snackbar(res, 'file upload success');
      setState(() {
        _file = null;
      });
      // await FirebaseFirestore.instance.collection('posts').doc(uid).
    } catch (e) {
      res = e.toString();
      Get.snackbar(res, "file upload fail. Please try again");
    }
  }

  void businessPostButton(String uid, Uint8List file, String description,
      String orgName, String profilePic) async {
    String res = 'Some Error Occured';
    try {
      String fileUrl = await postController.storeImage(file, 'posts', true);
      print(profilePic);
      String postId = Uuid().v1();

      Post post = Post(
          datePosted: DateTime.now(),
          description: description,
          username: orgName,
          likes: [],
          postId: postId,
          postUrl: fileUrl,
          uid: uid,
          type: 'photo',
          profilePic: profilePic,
          color: '#424242');

      await FirebaseFirestore.instance.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
      Get.snackbar(res, 'file upload success');
      setState(() {
        _file = null;
      });
      // await FirebaseFirestore.instance.collection('posts').doc(uid).
    } catch (e) {
      res = e.toString();
      Get.snackbar(res, "file upload fail. Please try again");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Upload a photo',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              IconButton(
                  onPressed: () => dialogBox(context),
                  icon: const Icon(
                    Icons.upload_outlined,
                    color: Colors.blueGrey,
                    size: 30.0,
                  ))
            ],
          )
        : FutureBuilder(
            future:
                FirebaseAuth.instance.currentUser!.displayName == 'job-seeker'
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
                              ? businessPostButton(
                                  user['uid'],
                                  _file!,
                                  descriptionController.text,
                                  user['orgName'],
                                  user['profilePhoto'])
                              : postButton(
                                  user['uid'],
                                  _file!,
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
                      SizedBox(
                        height: 350.0,
                        width: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 450 / 430,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          );
  }
}
