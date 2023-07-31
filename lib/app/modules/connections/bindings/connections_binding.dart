import 'package:get/get.dart';

import '../controllers/connections_controller.dart';

class ConnectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionsController>(
      () => ConnectionsController(),
    );
  }
}
