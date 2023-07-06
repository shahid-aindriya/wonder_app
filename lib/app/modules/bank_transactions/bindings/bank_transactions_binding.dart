import 'package:get/get.dart';

import '../controllers/bank_transactions_controller.dart';

class BankTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankTransactionsController>(
      () => BankTransactionsController(),
    );
  }
}
