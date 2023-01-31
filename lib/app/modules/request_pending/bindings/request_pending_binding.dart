import 'package:get/get.dart';

import '../controllers/request_pending_controller.dart';

class RequestPendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestPendingController>(
      () => RequestPendingController(),
    );
  }
}
