import 'package:get/get.dart';

import '../controllers/vendors_added_controller.dart';

class VendorsAddedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorsAddedController>(
      () => VendorsAddedController(),
    );
  }
}
