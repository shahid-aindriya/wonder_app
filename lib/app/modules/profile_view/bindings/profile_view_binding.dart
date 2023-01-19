import 'package:get/get.dart';

import '../controllers/profile_view_controller.dart';

class ProfileViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileViewController>(
      () => ProfileViewController(),
    );
  }
}
