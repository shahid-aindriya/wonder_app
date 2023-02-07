import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationDetailsController extends GetxController {
  //TODO: Implement RegistrationDetailsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;

  String licenceImage = '';
  File? image;
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      licenceImage = base64Encode(bytes);
    }
    // log(img);
    update();
  }
}
