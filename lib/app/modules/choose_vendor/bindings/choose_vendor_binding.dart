import 'package:get/get.dart';

import '../controllers/choose_vendor_controller.dart';

class ChooseVendorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseVendorController>(
      () => ChooseVendorController(),
    );
  }
}
