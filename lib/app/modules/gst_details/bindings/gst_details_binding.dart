import 'package:get/get.dart';

import '../controllers/gst_details_controller.dart';

class GstDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GstDetailsController>(
      () => GstDetailsController(),
    );
  }
}
