import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  String image;
  String? uid;

  PhotoViewScreen({super.key, required this.image, required this.uid});

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Picture Preview"),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: profileController.getUserImage(uid),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                child: PhotoView(
                  imageProvider: NetworkImage(snapshot.data.toString()),
                ),
              );
            }
          },
        )

        //  Container(
        //           child: PhotoView(
        //             imageProvider:
        //                 NetworkImage(),
        //           ),
        //         );
        // body: StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection("users")
        //         .doc(uid)
        //         .snapshots(),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       } else {
        //         return Container(
        //           child: PhotoView(
        //             imageProvider:
        //                 NetworkImage(snapshot.data.data()['profilePhoto']),
        //           ),
        //         );
        //       }
        //     }),
        );
  }
}
