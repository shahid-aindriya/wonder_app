import 'package:get/get.dart';

import '../controllers/my_earnings_controller.dart';

class MyEarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEarningsController>(
      () => MyEarningsController(),
    );
  }
}
