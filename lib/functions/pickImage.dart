import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    Get.snackbar("Image Selected", "Success Selecting Image");
    return await _file.readAsBytes();
  } else {
    Get.snackbar("No Image Selected", "Error Selecting image");
  }
  print('No image selected');
}
