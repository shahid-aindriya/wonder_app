import 'package:get/get.dart';

import '../controllers/upload_manually_controller.dart';

class UploadManuallyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadManuallyController>(
      () => UploadManuallyController(),
    );
  }
}
