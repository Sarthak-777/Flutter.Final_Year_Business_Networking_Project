import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/view/widgets/jobSkillWidget.dart';
import 'package:final_project_workconnect/view/widgets/skillsWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    print(authController.userData);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello ${authController.userData['username']} 👋 ",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find Jobs',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: 500,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  jobSkillWidget(
                    uid: authController.userData['uid'],
                    color: authController.userData['color'],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
