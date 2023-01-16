import 'package:get/get.dart';

import '../controllers/registration_details_controller.dart';

class RegistrationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationDetailsController>(
      () => RegistrationDetailsController(),
    );
  }
}
