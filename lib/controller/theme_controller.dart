import 'package:final_project_workconnect/constants.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool iconBool = false.obs;

  changeTheme() {
    iconBool.value = !iconBool.value;
    if (iconBool.value == true) {
      Get.changeTheme(darkTheme);
      update();
    } else {
      Get.changeTheme(lightTheme);
      update();
    }
  }
}
