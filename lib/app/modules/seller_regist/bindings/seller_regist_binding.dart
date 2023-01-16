import 'package:get/get.dart';

import '../controllers/seller_regist_controller.dart';

class SellerRegistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerRegistController>(
      () => SellerRegistController(),
    );
  }
}
