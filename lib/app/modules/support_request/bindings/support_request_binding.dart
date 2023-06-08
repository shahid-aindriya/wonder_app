import 'package:get/get.dart';

import '../controllers/support_request_controller.dart';

class SupportRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportRequestController>(
      () => SupportRequestController(),
    );
  }
}
