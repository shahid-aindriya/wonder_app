import 'package:get/get.dart';

import '../controllers/taxes_controller.dart';

class TaxesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaxesController>(
      () => TaxesController(),
    );
  }
}
