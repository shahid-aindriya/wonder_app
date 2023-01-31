import 'package:get/get.dart';

import '../controllers/password_generation_controller.dart';

class PasswordGenerationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordGenerationController>(
      () => PasswordGenerationController(),
    );
  }
}
