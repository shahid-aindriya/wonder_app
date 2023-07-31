import 'package:get/get.dart';

import '../controllers/wonder_list_controller.dart';

class WonderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WonderListController>(
      () => WonderListController(),
    );
  }
}
