import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/theme_controller.dart';
import 'package:final_project_workconnect/model/FirebaseHelper.dart';
import 'package:final_project_workconnect/model/business.dart';
import 'package:final_project_workconnect/view/screens/business/auth/business_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessHomeScreen extends StatefulWidget {
  const BusinessHomeScreen({super.key});

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  AuthController authController = Get.put(AuthController());
  ThemeController themeController = Get.put(ThemeController());
  User? currentBusiness;
  Business? thisBusinessModel;

  getBusinessInfo() async {
    currentBusiness = FirebaseAuth.instance.currentUser;
    thisBusinessModel =
        await FirebaseHelper.getBusinessModelById(currentBusiness!.uid);
  }

  @override
  Widget build(BuildContext context) {
    getBusinessInfo();
    print(thisBusinessModel);
    print(currentBusiness);
    return Scaffold(
      body: Container(
        color: iconBool ? Colors.black : Colors.grey[200],
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "WorkConnectBusiness",
                    style: GoogleFonts.roboto(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: iconBool ? Colors.white : Colors.black,
                    ),
                  ),
                  Row(children: [
                    IconButton(
                      color: iconBool ? Colors.white : kPrimaryColor,
                      onPressed: () {
                        themeController.changeTheme();
                        setState(() {
                          iconBool = !iconBool;
                        });
                        if (iconBool == true) {
                          Get.changeTheme(darkTheme);
                        } else {
                          Get.changeTheme(lightTheme);
                        }
                      },
                      icon: Icon(
                        iconBool ? iconDark : iconLight,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
