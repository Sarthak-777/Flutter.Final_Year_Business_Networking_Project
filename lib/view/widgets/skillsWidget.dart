import 'package:final_project_workconnect/view/screens/skills_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class skillsWidget extends StatelessWidget {
  const skillsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: () {
            Get.to(() => SkillsScreen());
          },
          child: Container(
            color: Colors.white,
            height: 100,
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
