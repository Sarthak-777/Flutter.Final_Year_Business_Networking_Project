import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/functions/postComments.dart';
import 'package:flutter/material.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:get/get.dart';

class BottomNavPostCommentField extends StatelessWidget {
  final snap;
  const BottomNavPostCommentField({
    Key? key,
    required TextEditingController textController,
    required this.snap,
  })  : _textController = textController,
        super(key: key);
  final TextEditingController _textController;

  submitComment(text, user) async {
    String response = await postComments(snap, text, user);
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    var user = authController.userData;
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 177, 177, 177),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 35.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintText: 'Write a comment',
                        hintStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: kCommentsColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: kCommentsColor),
                        )),
                  ),
                ),
                IconButton(
                  onPressed: () => submitComment(_textController.text, user),
                  icon: Icon(Icons.send, color: Colors.blueGrey[300]),
                ),
              ],
            ),
          ),
        ));
  }
}
