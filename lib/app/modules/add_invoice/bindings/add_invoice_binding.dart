import 'package:get/get.dart';

import '../controllers/add_invoice_controller.dart';

class AddInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInvoiceController>(
      () => AddInvoiceController(),
    );
  }
}
