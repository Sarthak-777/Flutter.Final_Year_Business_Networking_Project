// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:final_project_workconnect/constants.dart';

class CreatePost extends StatelessWidget {
  var userData;
  CreatePost({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgMainColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userData['profilePhoto']),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 1),
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Text('Create a post',
                    style: TextStyle(color: kPrimaryColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
