import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/widgets/commentBotNav.dart';
import 'package:final_project_workconnect/view/widgets/commentCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsScreen extends StatelessWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    AuthController authController = Get.put(AuthController());
    var user = authController.userData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: snap['likes'].contains(user['uid'])
                  ? Text(
                      'You and ${snap['likes'].length - 1} other likes',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    )
                  : Text(
                      '${snap['likes'].length} likes',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
              backgroundColor: Colors.black,
              elevation: 0,
              actions: [
                snap['likes'].contains(user['uid'])
                    ? const Icon(Icons.thumb_up, color: Colors.white)
                    : const Icon(Icons.thumb_up_outlined, color: Colors.white),
                const SizedBox(
                  width: 10.0,
                )
              ],
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(snap['postId'])
                  .collection('comments')
                  .orderBy('date', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => CommentCard(
                    snap: ((snapshot.data! as dynamic).docs[index].data()),
                  ),
                );
              },
            ),
            bottomNavigationBar: BottomNavPostCommentField(
                textController: _textController, snap: snap),
          ),
        ),
      ),
    );
  }
}
