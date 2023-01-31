import 'package:get/get.dart';

import '../../../../api/api_service.dart';

class PasswordGenerationController extends GetxController {
  //TODO: Implement PasswordGenerationController

  final ApiService _apiService = Get.put(ApiService());
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  var selectedRadio = 0;
  var isOn = false.obs;
  setSelectedRadio() {
    isOn.value = !isOn.value;
    update();
  }

  sellerRegister(
      {name, phone, email, adhaar, pan, password, adarImag, panImag}) async {
    var body = {
      "name": name,
      "phone": phone,
      "email": email,
      "adar_number": adhaar,
      "pan_number": pan,
      "auto_password": isOn.value,
      "password": password,
      "adar_image": adarImag,
      "pan_image": panImag
    };

    await _apiService.post("/vendor-register/", body);
  }
}
