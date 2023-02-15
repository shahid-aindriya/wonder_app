import 'package:get/get.dart';

import '../controllers/request_coins_controller.dart';

class RequestCoinsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestCoinsController>(
      () => RequestCoinsController(),
    );
  }
}
