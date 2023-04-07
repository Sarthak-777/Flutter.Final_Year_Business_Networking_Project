import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/job_controller.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:final_project_workconnect/view/screens/user/job_description_screen.dart';
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
  JobController jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    print(jobController.skillList);
    print(authController.userData['color']);
    // print(authController.userData);
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
            Obx(() => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      itemCount: jobController.skillList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            tileColor:
                                toColor(authController.userData['color']),
                            title: Text(
                              '${jobController.skillList[index].data()['jobTitle']}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "${jobController.skillList[index].data()['username']}\n${jobController.skillList[index].data()['jobTime']}    ${jobController.skillList[index].data()['jobType']}\n\n${jobController.skillList[index].data()['jobDesc']}",
                              style: TextStyle(),
                            ),
                            trailing: Text('View'),
                            isThreeLine: true,
                            onTap: () {
                              Get.to(() => JobDescriptionScreen(
                                  data: jobController.skillList[index].data(),
                                  color: authController.userData['color']));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
