import 'package:get/get.dart';

import '../controllers/my_shops_controller.dart';

class MyShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyShopsController>(
      () => MyShopsController(),
    );
  }
}
